---
title: "FT-002: Verifiable application startup baseline"
doc_kind: feature
doc_function: canonical
purpose: "Canonical scope and verify for root route, home page, and request spec proving Rails serves GET / with 200 HTML."
derived_from:
  - ../../domain/problem.md
  - ../../flows/feature-flow.md
status: active
delivery_status: done
issue_link: "https://github.com/bsboris/loki/issues/2"
must_not_define:
  - implementation_sequence
---

# FT-002: Verifiable application startup baseline

## What

### Problem

The project lacked a verification step that confirms the Rails application boots and that `GET /` returns HTTP 200. Without that baseline, developers and reviewers cannot confirm the application is running before validating subsequent product work.

### Outcome

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | Root HTTP availability | Undefined | `GET /` returns 200 with HTML | RSpec request spec + manual curl/browser |

### Scope

- `REQ-01` Configure `GET /` as the application root in `config/routes.rb` mapping to `home#index`.
- `REQ-02` Implement `HomeController#index` rendering `app/views/home/index.html.erb` with `200 OK` and HTML content type via standard Rails rendering.
- `REQ-03` Add one RSpec request spec for `GET /` asserting status 200 and HTML content type without depending on placeholder body text; runs in the existing suite without new gem dependencies.

### Non-scope

- `NS-01` Product documentation updates, manual-only runbooks, health checks, monitoring, deployment orchestration.
- `NS-02` Repositories, workspaces, translation, authentication, dashboard product behavior, extra routes, models, migrations, jobs, custom Rack middleware, non-Rails endpoint handling, new gems or frontend frameworks.

### Constraints / assumptions

- `ASM-01` Standard Rails 8 stack and RSpec as already configured in the repository.
- `CON-01` Only these areas may change for this slice: `config/routes.rb`, `app/controllers/home_controller.rb`, `app/views/home/index.html.erb`, one new request spec file for `GET /`.
- `DEC-01` None for this slice; foundation work precedes MVP features.

## How

### Solution

Expose a minimal root route and controller-rendered HTML page, with a single request spec as the automated proof of boot and routing.

### Change surface

| Surface | Type | Why it changes |
| --- | --- | --- |
| `config/routes.rb` | config | Root route definition |
| `app/controllers/home_controller.rb` | code | Root action |
| `app/views/home/index.html.erb` | code | HTML response body |
| `spec/requests/home_spec.rb` (or equivalent) | code | Automated verify |

### Flow

1. Client issues `GET /`.
2. Rails routes to `HomeController#index`, renders ERB template.
3. Response is 200 with `text/html`.

### Contracts

| Contract ID | Input / output | Producer / consumer | Notes |
| --- | --- | --- | --- |
| `CTR-01` | HTTP `GET /` → `200 OK`, `text/html` | Rails app / browser, tests | Public, no authentication |

### Failure modes

- `FM-01` Application fails to boot — feature not satisfied; out of scope for custom error pages in this slice.

### ADR dependencies

None.

## Verify

### Exit criteria

- `EC-01` Root route resolves to `HomeController#index`.
- `EC-02` Automated request spec proves 200 and HTML for `GET /`.

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `ASM-01`, `CON-01`, `CTR-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `ASM-01`, `CON-01`, `CTR-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-03` | `CON-01` | `EC-02`, `SC-02` | `CHK-01` | `EVID-01` |

### Acceptance scenarios

- `SC-01` Visiting `GET /` returns `200 OK` with HTML produced through `HomeController#index` and `app/views/home/index.html.erb`.
- `SC-02` The request spec for `GET /` passes and asserts HTTP 200 and HTML content type without brittle body coupling.

### Checks

| Check ID | Covers | How to check | Expected result | Evidence path |
| --- | --- | --- | --- | --- |
| `CHK-01` | `EC-01`, `EC-02`, `SC-01`, `SC-02` | `bin/rspec spec/requests/home_spec.rb` (or project’s home request spec path) | All examples green | `EVID-01` |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | Repository request spec for `GET /` |

### Evidence

- `EVID-01` Passing automated request coverage for `GET /` (see `spec/requests/home_spec.rb`).

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | RSpec examples | CI / local `bin/rspec` | `spec/requests/home_spec.rb` | `CHK-01` |
