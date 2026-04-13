---
title: "GitHub Repository Connection Spec"
brief_link: "memory-bank/features/004/brief.md"
issue_link: "https://github.com/bsboris/loki/issues/8"
status: done
---

## Goal

Define the minimum implementation needed for users to add GitHub repositories to Loki and verify their accessibility, so repositories can be connected to the system and made ready for translation workflows.

## Scope

Included in this feature:
- Add GitHub API integration using the `octokit` gem.
- Configure GitHub authentication via a shared Personal Access Token stored in Rails credentials.
- Add `GET /repositories/new` and `POST /repositories` routes for repository creation.
- Implement a form where users can enter repository owner and name.
- Synchronously verify repository accessibility with GitHub API during creation.
- Display validation errors when repository is inaccessible or already exists.
- Add automated tests for the GitHub API integration, repository creation flow, and error handling.

Not included in this feature:
- GitHub OAuth user authentication or per-user tokens.
- GitHub App installation or webhook integration.
- Asynchronous background job processing for verification.
- Repository import from user's GitHub account listing.
- Repository edit, update, or delete UI/endpoints.
- Branch listing, workspace creation, or file access.
- Retry mechanisms or status tracking for failed verifications.

Affected modules:
- Repository model (GitHub verification)
- Repository controller (new/create actions)
- Repository views (form and index updates)

## Invariants

- Repository identity remains uniquely defined by `provider`, `namespace_path`, and `name`.
- GitHub API verification must succeed before a repository record is persisted.
- GitHub authentication uses a single shared Personal Access Token configured in Rails credentials.
- Repository creation is synchronous: the form submission waits for GitHub API verification before responding.
- The `octokit` gem is the only new dependency introduced for GitHub API communication.
- All GitHub API calls must handle common error cases: repository not found, access denied, API rate limits, network errors.

## Requirements

1. GitHub API integration
   - Add `octokit` gem to the Gemfile.
   - Store GitHub Personal Access Token in Rails credentials under `github[:access_token]`.
   - Create a `GithubClient` PORO in `app/models/github_client.rb` that wraps Octokit initialization and authentication.
   - The class must provide a `verify_repository(owner, name)` method that verifies repository existence and accessibility.
   - The class will serve as foundation for future GitHub operations (branch fetching, PR creation, etc.).

2. Repository model
   - Add method to verify repository exists on GitHub using `GithubClient`.
   - Method delegates to `GithubClient#verify_repository(namespace_path, name)`.
   - On success, method completes without error.
   - On failure (repository not found, access denied, network error), catch the error raised by `GithubClient` and translate to validation error.
   - Add custom validation that calls verification method during creation.
   - Validation adds error if GitHub verification fails.

3. Controller and routing
   - Add routes: `GET /repositories/new` and `POST /repositories`.
   - Update repository index to include link to `new_repository_path`.
   - `RepositoriesController#new`: initialize new Repository, render form.
   - `RepositoriesController#create`: accept form parameters, attempt save (triggers verification), redirect on success or re-render with errors on failure.

4. Form view
   - Create `app/views/repositories/new.html.erb` with form submitting to `POST /repositories`.
   - Fields: `provider` (hidden, default `"github"`), `namespace_path` (labeled "Owner"), `name` (labeled "Repository Name").
   - Display validation errors and include submit button "Add Repository".
   - Use Rails `form_with` helper and daisyUI components from feature 003.

5. Error handling
   - Map GitHub API errors to user-friendly validation messages:
     - Not found → "Repository not found on GitHub"
     - 403 → "Cannot access this repository. Check if it exists and the token has permission."
     - Rate limit → "GitHub API rate limit exceeded. Please try again later."
     - Network/timeout → "Could not connect to GitHub. Please try again."
     - Duplicate → "Repository already exists in Loki."
   - Application must not crash on GitHub API failures.

6. Automated verification
   - Model specs for `GithubClient` (`spec/models/github_client_spec.rb`): successful verification, not found error, access denied error, network error handling. Stub HTTP with WebMock.
   - Model specs for `Repository`: successful verification using mocked `GithubClient`, validation errors.
   - Request specs: `GET /repositories/new` returns 200, `POST /repositories` creates on success and redirects, shows errors on failure, handles duplicates.
   - Mock `GithubClient` in repository model/controller specs.

## States

- Loading: not applicable. GitHub verification is synchronous and happens during form submission. No client-side loading state is required.
- Success:
  - `GET /repositories/new` returns `200 OK` and renders the repository creation form.
  - `POST /repositories` with valid data successfully verifies the repository with GitHub, creates the record, and redirects to `GET /repositories` with a success message.
  - The repository index displays the new repository.
- Error:
  - `POST /repositories` with a repository that doesn't exist on GitHub re-renders the form with error: "Repository not found on GitHub."
  - `POST /repositories` with a repository that is inaccessible re-renders the form with error: "Cannot access this repository. Check if it exists and the token has permission."
  - `POST /repositories` with a duplicate repository re-renders the form with error: "Repository already exists in Loki."
  - GitHub API rate limit errors re-render the form with error: "GitHub API rate limit exceeded. Please try again later."
  - Network failures re-render the form with error: "Could not connect to GitHub. Please try again."

## Acceptance Criteria

1. The `octokit` gem is added to the Gemfile and installed.
2. Rails credentials include a `github[:access_token]` entry for GitHub authentication.
3. A `GithubClient` PORO in `app/models/` exists with a `verify_repository(owner, name)` method.
4. The `Repository` model uses `GithubClient` to verify repository accessibility on GitHub.
5. `GET /repositories/new` is routed to `RepositoriesController#new` and returns `200 OK`.
6. `GET /repositories/new` renders a form with fields for owner and name.
7. `POST /repositories` is routed to `RepositoriesController#create`.
8. `POST /repositories` with valid data synchronously verifies the repository with GitHub and creates a record on success.
9. `POST /repositories` with valid data redirects to `/repositories` with a success message after creation.
10. `POST /repositories` with an invalid or inaccessible GitHub repository re-renders the form with the corresponding error message as defined in requirement 5.
11. `POST /repositories` with a duplicate repository re-renders the form with a uniqueness error.
12. The repository index page includes a link to add a new repository.
13. GitHub API errors (not found, access denied, rate limit, network) are handled gracefully and display user-friendly messages.
14. Automated tests cover `GithubClient` service, successful creation, GitHub API error cases, and duplicate repository handling.

## Implementation Constraints

- Use standard Rails conventions for routes, controller actions, forms, and validations.
- Add only the `octokit` gem as a new dependency.
- Create a `GithubClient` PORO in `app/models/` that wraps Octokit and provides GitHub API operations. This class will be extended in future features for branch fetching, PR creation, etc.
- Use synchronous verification; do not introduce background job processing in this feature.
- Store the GitHub token in Rails credentials, not environment variables or database.
- Handle all common GitHub API error scenarios with user-friendly messages.
- Do not implement repository editing, deletion, or bulk import in this feature.
- Do not implement GitHub OAuth or per-user authentication in this feature.
- Preserve backwards compatibility: existing repository records without GitHub metadata remain valid.
- Use daisyUI components from feature 003 for form styling.
