---
title: "FT-008: Implementation Plan"
doc_kind: feature
doc_function: derived
purpose: "Archived execution plan for Octokit, GithubClient, repository create validation, routes, and specs."
derived_from:
  - feature.md
status: archived
must_not_define:
  - ft_008_scope
  - ft_008_architecture
  - ft_008_acceptance_criteria
  - ft_008_blocker_state
---

# Implementation plan

## Plan goal

Add synchronous GitHub metadata fetch on create, expose `new`/`create`, harden error mapping, and cover with WebMock + doubles.

## Current state / reference points

| Path / module | Current role | Why relevant | Reuse / mirror |
| --- | --- | --- | --- |
| `app/models/repository.rb` | Aggregate | Hook GitHub client | `before_validation` on create |
| `config/credentials.yml.enc` pattern | Secrets | PAT storage | Never commit secrets |
| `spec/rails_helper.rb` | RSpec config | WebMock disable net | Required for client specs |
| `memory-bank/adr/ADR-001-git-as-single-source-of-truth.md` | Decision | Git boundary | Align error handling |

## Test strategy

| Test surface | Canonical refs | Existing coverage | Planned automated coverage | Required local suites / commands | Required CI suites / jobs | Manual-only gap / justification | Manual-only approval ref |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `GithubClient` | `REQ-01`, `SC-05` | `github_client_spec` | HTTP stubs, error classes | `bin/rspec spec/models/github_client_spec.rb` | CI | Real GitHub PAT smoke | human — optional `AG-01` |
| `Repository` | `REQ-02`, `SC-02`, `SC-03` | `repository_spec` | Stubs for create | `bin/rspec spec/models/repository_spec.rb` | CI | none | none |
| HTTP flow | `REQ-03`, `SC-01`, `SC-04` | `repositories_spec` | new/create + errors | `bin/rspec spec/requests/repositories_spec.rb` | CI | none | none |

## Open questions / ambiguities

| Open question ID | Question | Why unresolved | Blocks | Default action / escalation owner |
| --- | --- | --- | --- | --- |
| `OQ-01` | none at archive | n/a | none | n/a |

## Environment contract

| Area | Contract | Used by | Failure symptom |
| --- | --- | --- | --- |
| secrets | `rails credentials:edit` populates `github[:access_token]` for manual smoke | human tester | Live calls fail |
| test | WebMock on; allow localhost | `STEP-01`, specs | Flaky external calls |

## Preconditions

| Precondition ID | Canonical ref | Required state | Used by steps | Blocks start |
| --- | --- | --- | --- | --- |
| `PRE-01` | `ASM-01` | Bundler can install new gems | `STEP-01` | yes |
| `PRE-02` | `CON-01` | Credentials doc for humans (not in repo) | manual smoke | no |

## Workstreams

| Workstream | Implements | Result | Owner | Dependencies |
| --- | --- | --- | --- | --- |
| `WS-1` | `REQ-01` | Client + deps | agent | `PRE-01` |
| `WS-2` | `REQ-02` | Model integration | agent | `WS-1` |
| `WS-3` | `REQ-03` | Controller + views | agent | `WS-2` |
| `WS-4` | `REQ-04` | Specs | agent | `WS-3` |

## Approval gates

| Approval gate ID | Trigger | Applies to | Why approval is required | Approver / evidence |
| --- | --- | --- | --- | --- |
| `AG-01` | Manual smoke against real GitHub | optional validation | Uses live credentials and rate limits | human maintainer |

## Work order

| Step ID | Actor | Implements | Goal | Touchpoints | Artifact | Verifies | Evidence IDs | Check command / procedure | Blocked by | Needs approval | Escalate if |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `STEP-01` | agent | `REQ-01` | Add gems, WebMock config, `GithubClient` | `Gemfile`, `spec/rails_helper.rb`, `app/models/github_client.rb` | Client spec green | `CHK-01` | `EVID-01` | `bin/rspec spec/models/github_client_spec.rb` | `PRE-01` | none | network in tests |
| `STEP-02` | agent | `REQ-02` | Model callback + errors | `app/models/repository.rb`, specs | Create path safe | `CHK-01` | `EVID-01` | `bin/rspec spec/models/repository_spec.rb` | `STEP-01` | none | validation gaps |
| `STEP-03` | agent | `REQ-03` | Routes + controller + forms + flash | routes, controller, views, layout | UX matches spec | `CHK-01` | `EVID-01` | `bin/rspec spec/requests/repositories_spec.rb` | `STEP-02` | none | routing regressions |
| `STEP-04` | agent | `REQ-04` | Full suite + lint | all touched specs | CI-ready | `CHK-01` | `EVID-01` | `bin/rspec` + `bin/rubocop` | `STEP-03` | none | CI failures |

## Parallelizable work

- `PAR-01` Client specs (`STEP-01`) independent from view polish until controller contracts freeze—still sequence model before request integration.

## Checkpoints

| Checkpoint ID | Refs | Condition | Evidence IDs |
| --- | --- | --- | --- |
| `CP-01` | `STEP-01` | GithubClient spec green | `EVID-01` |
| `CP-02` | `STEP-04` | Full suite + RuboCop green | `EVID-01` |

## Execution risks

| Risk ID | Risk | Impact | Mitigation | Trigger |
| --- | --- | --- | --- | --- |
| `ER-01` | Token missing locally | Manual smoke blocked | Document credentials setup | `ConfigurationError` in dev |

## Stop conditions / fallback

| Stop ID | Related refs | Trigger | Immediate action | Safe fallback state |
| --- | --- | --- | --- | --- |
| `STOP-01` | `FM-01` | Cannot map GitHub errors safely | Stop merge; fix client | Revert client integration |

## Ready for acceptance

All `CHK-01` conditions in sibling `feature.md` satisfied; optional `AG-01` recorded if manual smoke run.
