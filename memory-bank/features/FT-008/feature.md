---
title: "FT-008: GitHub repository connection"
doc_kind: feature
doc_function: canonical
purpose: "Canonical scope and verify for Octokit-backed GitHub verification and synchronous repository create via new/create."
derived_from:
  - ../../domain/problem.md
  - ../../flows/feature-flow.md
status: active
delivery_status: done
issue_link: "https://github.com/bsboris/loki/issues/8"
must_not_define:
  - implementation_sequence
---

# FT-008: GitHub repository connection

## What

### Problem

Users could not connect GitHub repositories to Loki, blocking translation workflows that depend on Git-hosted files.

### Outcome

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | Connected GitHub repos | Create blocked | User can submit owner/name; system verifies via GitHub; record persists on success | Request + model specs; manual smoke with token |

### Scope

- `REQ-01` Add `octokit` gem; store shared PAT in Rails credentials `github[:access_token]`; implement `GithubClient` wrapping Octokit with `fetch_repository(qualified_name)` returning the host default branch, raising typed errors for not found, access denied, rate limit, network, and configuration when token missing.
- `REQ-02` On GitHub-backed create, resolve `default_base_ref` from GitHub before persist (`before_validation` or equivalent); map client errors to user-facing validation messages on the record; handle duplicate composite identity in Loki.
- `REQ-03` Routes `GET /repositories/new` and `POST /repositories`; `new` renders form; `create` saves or re-renders with errors; index links to add flow; use established UI patterns (daisyUI from FT-062).
- `REQ-04` Automated tests: `GithubClient` with HTTP stubbing (WebMock), `Repository` behavior with doubles, request specs for happy path and error/duplicate paths.

### Non-scope

- `NS-01` GitHub OAuth, GitHub App, webhooks, async jobs, import-from-account listing, edit/destroy, branch listing, workspace/file flows, retry/status tracking beyond synchronous request.

### Constraints / assumptions

- `ASM-01` GitHub is the MVP host; credentials hold shared token for this slice.
- `CON-01` Synchronous verification only; token not committed to repo.
- `DEC-01` Exact `GithubClient` method names may evolve but verify contract remains: fail closed on GitHub errors.

## How

### Solution

Centralize GitHub access in a small client, hook verification into `Repository` lifecycle on create for `provider == github`, expose Rails form flow, and cover with isolated tests using stubs.

### Change surface

| Surface | Type | Why it changes |
| --- | --- | --- |
| `Gemfile`, `Gemfile.lock` | config | `octokit`, test stubs |
| `app/models/github_client.rb`, `app/models/repository.rb` | code | Integration + validation |
| `config/routes.rb`, `app/controllers/repositories_controller.rb` | config / code | New/create |
| `app/views/repositories/new.html.erb`, index updates, layout flash | code | UX |
| `spec/models/github_client_spec.rb`, repository/request specs, `spec/rails_helper.rb` | code | Verify |

### Flow

1. User opens new repository form, enters owner and name.
2. On submit, model triggers GitHub verification; success persists and redirects with notice; failure re-renders form with errors.

### Contracts

| Contract ID | Input / output | Producer / consumer | Notes |
| --- | --- | --- | --- |
| `CTR-01` | GitHub API accessibility for `(namespace_path, name)` | `GithubClient` / `Repository` | Must pass before insert |
| `CTR-02` | HTTP form + flash feedback | Controller / user | Standard Rails semantics |

### Failure modes

- `FM-01` GitHub API errors — must surface mapped messages, not 500, per acceptance.
- `FM-02` Missing/invalid token configuration — fail with clear configuration error path covered in tests.

### ADR dependencies

| ADR | Current `decision_status` | Used for | Execution rule |
| --- | --- | --- | --- |
| [../../adr/ADR-001-git-as-single-source-of-truth.md](../../adr/ADR-001-git-as-single-source-of-truth.md) | `accepted` | GitHub boundary and Git as SoT | Do not contradict the Git layer contract |

## Verify

### Exit criteria

- `EC-01` Gem and credentials contract satisfied (`REQ-01`).
- `EC-02` Create flow and error mapping satisfied (`REQ-02`–`REQ-03`).
- `EC-03` Spec coverage satisfied (`REQ-04`).

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `ASM-01`, `CON-01`, `CTR-01`, `FM-02` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `CTR-01`, `FM-01` | `EC-02`, `SC-02`, `SC-03` | `CHK-01` | `EVID-01` |
| `REQ-03` | `CTR-02`, `CON-01` | `EC-02`, `SC-04` | `CHK-01` | `EVID-01` |
| `REQ-04` | `CON-01` | `EC-03`, `SC-05` | `CHK-01` | `EVID-01` |

### Acceptance scenarios

- `SC-01` Happy-path GitHub verification persists repository and redirects to index with success feedback.
- `SC-02` Not found / access denied / rate limit / network failures show the specified user-facing messages on `422` (or equivalent) re-render.
- `SC-03` Duplicate composite identity shows duplicate-in-Loki style error.
- `SC-04` `GET /repositories/new` renders form fields (owner/name, hidden provider).
- `SC-05` Automated suite covers client, model integration, and request flows with stubs.

### Checks

| Check ID | Covers | How to check | Expected result | Evidence path |
| --- | --- | --- | --- | --- |
| `CHK-01` | `EC-01`–`EC-03`, `SC-01`–`SC-05` | `bin/rspec` (see evidence paths); `bin/rubocop` | All green | `EVID-01` |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | `spec/models/github_client_spec.rb`, `spec/models/repository_spec.rb`, `spec/requests/repositories_spec.rb`; RuboCop from repo root |

### Evidence

- `EVID-01` Passing RSpec and RuboCop for this change surface (CI or local).

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | Test and lint output | CI / developer | Spec paths above + RuboCop | `CHK-01` |
