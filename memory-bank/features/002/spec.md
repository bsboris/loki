---
title: "Repository Registration Baseline Spec"
brief_link: "memory-bank/features/002/brief.md"
status: active
---

## Goal

Define the minimum implementation needed for Loki to store tracked repositories and present them in a server-rendered Rails HTML index page, so repository records can exist in the system for later setup flows.

## Scope

Included in this feature:
- Add a `Repository` domain model backed by persistent storage.
- Add the database structure required to store repository records.
- Store these repository attributes:
  - `provider`
  - `namespace_path`
  - `name`
  - `default_base_ref`
- Enforce repository identity by the combination of `provider`, `namespace_path`, and `name`.
- Add the `GET /repositories` HTML endpoint.
- Render an index page that shows persisted repository records.
- Add automated tests for the model constraints and the repository index endpoint.

Not included in this feature:
- Repository creation UI or create endpoint.
- Repository show, edit, update, or delete UI/endpoints.
- GitHub API integration, provider syncing, or repository import flows.
- Validation against a remote provider.
- Workspace creation, repository configuration, authentication, or authorization.
- JSON API support.

Affected modules:
- Repository persistence (`repositories` table and `Repository` model)
- Repository index web interface (`GET /repositories`, controller action, and HTML view)
- Automated verification (model and request specs)

## Invariants

- Repository identity is uniquely defined by the combination of `provider`, `namespace_path`, and `name`.
- `provider`, `namespace_path`, `name`, and `default_base_ref` are always required at both the model and database layers.
- `default_base_ref` defaults to `"main"` when a repository record is created without an explicit value.
- This feature is read-only over HTTP. It adds only `GET /repositories` and no other repository routes.
- This feature does not perform provider API calls, repository syncing, workspace logic, authentication, or authorization.

## Requirements

1. Persistence
   - Add a `repositories` table.
   - The table must store:
     - `provider`
     - `namespace_path`
     - `name`
     - `default_base_ref`
     - Rails-managed timestamps
   - `provider`, `namespace_path`, and `name` must be required at the database level.
   - `default_base_ref` must be required at the database level and must default to `"main"`.
   - The database must enforce uniqueness for the composite key `provider + namespace_path + name`.

2. Repository model
   - Implement a `Repository` model inheriting from `ApplicationRecord`.
   - The model must validate presence of:
     - `provider`
     - `namespace_path`
     - `name`
     - `default_base_ref`
   - The model must validate uniqueness of `name` scoped to `provider` and `namespace_path`.
   - The model must not include provider-specific behavior, network access, sync logic, or workspace behavior in this feature.

3. Routing and controller
   - The route must expose `GET /repositories`.
   - The route must resolve to `RepositoriesController#index`.
   - Implement `RepositoriesController#index`.
   - `RepositoriesController#index` must load repository records from the database and render `app/views/repositories/index.html.erb`.
   - No other `repositories` routes may be added in this feature.

4. HTML index page
   - Render a dedicated ERB template at `app/views/repositories/index.html.erb`.
   - The page must return `200 OK` with HTML content type.
   - Loading state: not applicable. This page is rendered synchronously on the server and does not implement a client-side loading state.
   - Empty state: when there are zero repository records, the page must render the text `No repositories yet`.
   - Success state: for each persisted repository record, the page must display:
     - `provider`
     - `namespace_path`
     - `name`
     - `default_base_ref`
   - Error state: no custom application-level error UI or error handling is implemented in this feature.
   - Unhandled exception behavior is out of scope for this feature and is not part of the acceptance criteria.
   - The page does not need pagination, filtering, search, sorting controls, or action buttons.

5. Automated verification
   - Add model specs that cover:
     - required attributes
     - composite uniqueness for `provider + namespace_path + name`
     - `default_base_ref` is required
     - `default_base_ref` defaults to `"main"` when a record is created without an explicit value
   - Add a request spec for `GET /repositories`.
   - The request spec must assert:
     - response status is `200 OK`
     - response content type is HTML
     - the page renders `No repositories yet` with no records
     - the page renders persisted repository data
     - the page renders `default_base_ref` for each persisted repository
     - no other `repositories` routes are present
   - The specs must run under the existing RSpec suite without adding dependencies.

## Acceptance Criteria

1. A `repositories` table exists with columns for `provider`, `namespace_path`, `name`, `default_base_ref`, and timestamps.
2. The database rejects duplicate repository records with the same `provider`, `namespace_path`, and `name`.
3. A `Repository` model exists and validates presence of `provider`, `namespace_path`, `name`, and `default_base_ref`.
4. `default_base_ref` is not nullable and defaults to `"main"`.
5. `GET /repositories` is routed to `RepositoriesController#index`.
6. A request to `GET /repositories` returns `200 OK`.
7. A request to `GET /repositories` returns an HTML response.
8. When the database contains zero repository records, the repository index page includes the text `No repositories yet`.
9. The repository index page displays persisted repository records, including `provider`, `namespace_path`, `name`, and `default_base_ref`.
10. Only `GET /repositories` is added for repositories. No create, show, edit, update, destroy, import, sync, or workspace routes or behavior are implemented as part of this feature.

## Restrictions

- Use standard Rails conventions for the model, migration, route, controller, view, and RSpec coverage.
- Do not add new gems, frontend frameworks, service objects, or custom abstractions for this feature.
- Keep the feature server-rendered with standard Rails HTML views.
- Do not add JSON endpoints, Hotwire flows, JavaScript-dependent interactions, or provider API integration.
- Do not add repository creation forms or any non-index repository screens.
- Do not implement soft delete. If repository deletion is introduced outside this spec in later work, it should be hard delete rather than soft delete.
