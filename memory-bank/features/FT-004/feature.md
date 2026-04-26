---
title: "FT-004: Repository registration baseline"
doc_kind: feature
doc_function: canonical
purpose: "Canonical scope and verify for Repository persistence and read-only GET /repositories HTML index."
derived_from:
  - ../../domain/problem.md
  - ../../flows/feature-flow.md
status: active
delivery_status: done
issue_link: "https://github.com/bsboris/loki/issues/4"
must_not_define:
  - implementation_sequence
---

# FT-004: Repository registration baseline

## What

### Problem

Users could not create or store repository records, blocking repository-dependent MVP flows (GitHub integration, configuration, workspaces).

### Outcome

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | Persisted repositories visible in UI | Zero records | Records stored with required fields; index lists them | Model + request specs; manual browser |

### Scope

- `REQ-01` Add `repositories` table with `provider`, `namespace_path`, `name`, `default_base_ref`, timestamps; DB-level presence; composite uniqueness on `provider` + `namespace_path` + `name`; `default_base_ref` non-null with default `"main"`.
- `REQ-02` `Repository` model with presence validations and uniqueness of `name` scoped to `provider` and `namespace_path`; no provider API or workspace logic in this slice.
- `REQ-03` Expose only `GET /repositories` → `RepositoriesController#index`, loading records and rendering `app/views/repositories/index.html.erb`.
- `REQ-04` Index page: `200 OK`, HTML; empty copy `No repositories yet`; success shows `provider`, `namespace_path`, `name`, `default_base_ref` per row; no pagination/actions required.
- `REQ-05` Automated tests: model specs (validations, uniqueness, default ref) and request spec for index behavior and route constraint (no extra repository routes).

### Non-scope

- `NS-01` Create/update/destroy UI or endpoints, GitHub API or import, remote validation, workspaces, authz, JSON APIs, custom error UX beyond default Rails.

### Constraints / assumptions

- `ASM-01` Server-rendered Rails HTML and existing RSpec conventions.
- `CON-01` Read-only HTTP for repositories beyond this slice’s index; standard Rails model/migration/controller/view layout.
- `DEC-01` None recorded for this baseline.

## How

### Solution

Introduce the `Repository` ActiveRecord model with strict persistence rules and a single index endpoint backed by model and request specs.

### Change surface

| Surface | Type | Why it changes |
| --- | --- | --- |
| `db/migrate/*_create_repositories.rb`, `db/schema.rb` | data | Table and constraints |
| `app/models/repository.rb` | code | Domain rules |
| `config/routes.rb` | config | `resources :repositories, only: [:index]` (or equivalent) |
| `app/controllers/repositories_controller.rb` | code | Index action |
| `app/views/repositories/index.html.erb` | code | Listing UI |
| `spec/models/repository_spec.rb`, `spec/requests/repositories_spec.rb` | code | Verify |

### Flow

1. User opens `GET /repositories`.
2. Controller loads `Repository.all` (or ordered scope), renders template.
3. Browser receives HTML list or empty state message.

### Contracts

| Contract ID | Input / output | Producer / consumer | Notes |
| --- | --- | --- | --- |
| `CTR-01` | Composite identity `(provider, namespace_path, name)` unique | DB / app | Enforced at DB and model |
| `CTR-02` | `GET /repositories` → `200` HTML listing | Controller / user, tests | Only repository route added |

### Failure modes

- `FM-01` Duplicate identity — record rejected; not required to customize UI in this slice beyond validations surfacing as needed later.

### ADR dependencies

None.

## Verify

### Exit criteria

- `EC-01` Schema and model match `REQ-01`–`REQ-02`.
- `EC-02` Index route and rendering match `REQ-03`–`REQ-04`.
- `EC-03` Spec coverage matches `REQ-05`.

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `ASM-01`, `CON-01`, `CTR-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `CON-01`, `CTR-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-03` | `CTR-02` | `EC-02`, `SC-02` | `CHK-01` | `EVID-01` |
| `REQ-04` | `CTR-02` | `EC-02`, `SC-02`, `SC-03` | `CHK-01` | `EVID-01` |
| `REQ-05` | `CON-01` | `EC-03`, `SC-04` | `CHK-01` | `EVID-01` |

### Acceptance scenarios

- `SC-01` Creating valid repository rows persists required fields and respects composite uniqueness.
- `SC-02` `GET /repositories` returns 200 HTML with `No repositories yet` when zero rows.
- `SC-03` With persisted rows, index shows all four attributes per repository.
- `SC-04` Unsupported repository routes (for example `new`, `show`) are not routable where asserted by spec.

### Checks

| Check ID | Covers | How to check | Expected result | Evidence path |
| --- | --- | --- | --- | --- |
| `CHK-01` | `EC-01`–`EC-03`, `SC-01`–`SC-04` | `bin/rspec spec/models/repository_spec.rb spec/requests/repositories_spec.rb` | Green | `EVID-01` |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | `spec/models/repository_spec.rb`, `spec/requests/repositories_spec.rb` |

### Evidence

- `EVID-01` Passing model and request specs for repository index and constraints.

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | RSpec suite output | CI / local | Above spec paths | `CHK-01` |
