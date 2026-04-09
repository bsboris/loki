---
title: "Startup Verification Baseline Spec"
issue_link: "https://github.com/bsboris/loki/issues/2"
status: active
---

## Goal

Define the minimum implementation needed to verify that the Rails application boots successfully and serves `GET /` with HTTP `200`.

## Scope

Included in this feature:
- Add the application root route for `GET /`.
- Implement a conventional Rails controller action and dedicated view template for the root page.
- Add an RSpec request spec for `GET /`.

Not included in this feature:
- Project documentation updates, including manual verification instructions.
- Health checks, monitoring, deployment checks, or environment orchestration.
- Product features such as repositories, workspaces, translation editing, publishing, authentication, or dashboard behavior.
- New gems, new frontend frameworks, or custom request-handling infrastructure.

Affected modules:
- Routing
- Home page endpoint (`HomeController#index` and its view)
- Request spec

## Requirements

1. Routing
   - Configure `GET /` as the application root route.
   - The route must be defined in `config/routes.rb`.
   - The route must resolve to `HomeController#index`.

2. Home page endpoint
   - Implement `HomeController` with an `index` action.
   - Render `app/views/home/index.html.erb`.
   - A successful `GET /` response must return:
     - HTTP status `200 OK`
     - content type `text/html`
   - The response must be produced by `HomeController#index` rendering `app/views/home/index.html.erb` through Rails' standard controller/template rendering flow.

3. Automated verification
   - Add one RSpec request spec file that exercises `GET /`.
   - The request spec must assert:
     - response status is `200 OK`
     - response content type is HTML
   - The request spec must not depend on placeholder body text.
   - The spec must run under the existing RSpec suite without adding dependencies.

## States

- Success: `GET /` returns `200 OK` with HTML from `HomeController#index`.
- Loading: not applicable; this feature is server-rendered and defines no client-side loading state.
- Empty: not applicable; this feature only requires an HTML page shell, not data-backed content.
- Error handling:
  - If the Rails application fails to boot, the feature is considered not satisfied.
  - No custom error page, retry flow, or fallback behavior is required by this feature.

## Invariants

- `GET /` remains publicly accessible with no authentication requirement.
- The root endpoint remains implemented through standard Rails routing, controller, and view layers.
- No models, migrations, jobs, API endpoints, or additional routes are added for this feature.
- No product workflow behavior is introduced.
- No new dependencies are introduced.

## Acceptance Criteria

1. `config/routes.rb` defines the root route for `GET /` and maps it to `home#index`.
2. `HomeController#index` exists and renders `app/views/home/index.html.erb`.
3. A request to `GET /` returns `200 OK`.
4. A request to `GET /` returns an HTML response.
5. One RSpec request spec exists for `GET /`, and it asserts `200 OK` and HTML content type.
6. The implementation adds no models, migrations, jobs, extra routes, authentication checks, Git integration classes, or translation-domain controllers.

## Implementation Constraints

- Define the root route in `config/routes.rb`.
- Implement `HomeController#index`.
- Render `app/views/home/index.html.erb`.
- Add exactly one request spec file for `GET /`.
- Only these files may be added or modified for this feature:
  - `config/routes.rb`
  - `app/controllers/home_controller.rb`
  - `app/views/home/index.html.erb`
  - one request spec file for `GET /`
- Do not introduce custom Rack middleware, low-level Rack responses, or non-Rails endpoint handling.
- Do not add documentation requirements to this feature.
