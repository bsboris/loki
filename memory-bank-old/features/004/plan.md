---
title: "GitHub Repository Connection Implementation Plan"
spec_link: "memory-bank/features/004/spec.md"
status: done
---

## Overview

Implement GitHub repository connection: add `octokit`, create a `GithubClient` service, wire GitHub verification into the Repository model as a create-time validation, and expose `new`/`create` routes with a form.

## Steps

### 1. Add octokit gem
Add `gem "octokit"` to `Gemfile` and run `bundle install`.

Also add `gem "webmock"` to a separate `group :test` block for HTTP stubbing in specs. Configure `WebMock.disable_net_connect!(allow_localhost: true)` in `spec/rails_helper.rb`.

### 2. Create GithubClient PORO
Create `app/models/github_client.rb`.

- Wraps `Octokit::Client` initialized with token from `Rails.application.credentials.dig(:github, :access_token)`.
- Defines a custom error hierarchy: `Error`, `NotFoundError`, `AccessDeniedError`, `RateLimitError`, `ConnectionError`.
- Public method `verify_repository(owner, name)` calls `client.repository("owner/name")`, returns `true` on success, raises typed errors for 404, 403, rate limit, and network failures.
- Token is injectable via constructor argument to allow test overrides.

### 3. Add GitHub verification to Repository model
Update `app/models/repository.rb`.

- Define a `github?` predicate method: `def github? = provider == "github"`.
- Add custom validation `verify_github_accessibility`, scoped `on: :create` and guarded by `if: :github?`.
- Calls `GithubClient.new.verify_repository(namespace_path, name)`.
- Rescues each `GithubClient` error subclass and adds a user-friendly message to `errors[:base]`.
- Error messages per spec requirement 5.

### 4. Update existing specs to stub GithubClient
Update `spec/models/repository_spec.rb` and `spec/requests/repositories_spec.rb` to mock `GithubClient` wherever `create!` or `save` is called with `provider: "github"`, so the new validation does not attempt a real API call.

Specifically:
- In `repository_spec.rb`: the `defaults` spec and the `database constraints` spec both call `described_class.create!(provider: "github", ...)` — wrap each with an `instance_double` stub on `GithubClient`.
- In `repositories_spec.rb`: the `GET /repositories` spec that seeds two repositories includes one with `provider: "github"` — stub `GithubClient` there too.
- Remove the assertion that `GET /repositories/new` raises `RoutingError` (it will be a valid route after step 5).

### 5. Update routes
Change `only: %i[index]` to `only: %i[index new create]` in `config/routes.rb`.

### 6. Ensure flash messages display in layout
Update `app/views/layouts/application.html.erb` to render `notice` and `alert` flash messages above `<%= yield %>`. Add if missing.

### 7. Add controller actions
Update `app/controllers/repositories_controller.rb`.

- `new`: initialize `Repository.new(provider: "github")`, render with locals.
- `create`: build from `params`, call `save`, redirect to `repositories_path` with notice on success, re-render `:new` with `status: :unprocessable_entity` on failure.
- Add private `repository_params` permitting `provider`, `namespace_path`, `name`.

### 8. Extend alert partial
Update `app/views/shared/ui/_alert.html.erb` to support `variant: :error` → `alert-error` CSS class.

### 9. Create form view
Create `app/views/repositories/new.html.erb`.

- Match existing page structure (section > header with catalog label).
- Fields: hidden `provider` (value `"github"`), `namespace_path` (label "Owner"), `name` (label "Repository Name").
- Display validation errors at the top: iterate `repository.errors.full_messages` and render each message using the `shared/ui/alert` partial with `variant: :error`.
- Submit button "Add Repository".

### 10. Update index page
Update `app/views/repositories/index.html.erb` to add a link to `new_repository_path` in the header area.

## Tests

- `spec/models/github_client_spec.rb` — stub HTTP with WebMock; cover success, 404, 403, rate limit, connection failure.
- `spec/models/repository_spec.rb` — mock `GithubClient` with `instance_double`; cover successful save, each error case, and that non-github providers skip verification. Existing specs updated in step 4.
- `spec/requests/repositories_spec.rb` — cover `GET /repositories/new` (200, form present), `POST /repositories` (success → redirect, GitHub errors → 422 with message, duplicate → 422 with uniqueness message). Existing specs updated in step 4.

## Verification

```
bin/rspec
bin/rubocop
```

Manual smoke test: add a real repo, add a nonexistent repo, add a duplicate.

## Risks

- GitHub token must be added to Rails credentials before any manual testing. Do not commit the token.
- Synchronous verification means form submission latency includes a GitHub API round-trip.
