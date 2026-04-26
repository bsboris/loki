---
title: "FT-004: Implementation Plan"
doc_kind: feature
doc_function: derived
purpose: "Archived execution plan for repositories migration, model, index endpoint, and specs."
derived_from:
  - feature.md
status: archived
must_not_define:
  - ft_004_scope
  - ft_004_architecture
  - ft_004_acceptance_criteria
  - ft_004_blocker_state
---

# Implementation plan

## Plan goal

Persist `Repository` rows with composite uniqueness and expose read-only `GET /repositories` with model and request coverage.

## Current state / reference points

| Path / module | Current role | Why relevant | Reuse / mirror |
| --- | --- | --- | --- |
| `db/schema.rb` | Schema SSoT | Confirms table shape | Update via migration |
| `app/models/application_record.rb` | AR base | Model inheritance | Standard pattern |
| `config/routes.rb` | Routing | Only index route for this slice | `only: [:index]` |
| `bin/rspec`, `bin/rubocop` | Verify gates | Engineering policy | Full suite before merge |

## Test strategy

| Test surface | Canonical refs | Existing coverage | Planned automated coverage | Required local suites / commands | Required CI suites / jobs | Manual-only gap / justification | Manual-only approval ref |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Model | `REQ-01`, `REQ-02`, `SC-01` | `repository_spec` | Validations, uniqueness, default ref | `bin/rspec spec/models/repository_spec.rb` | CI default | none | none |
| Index HTTP | `REQ-03`, `REQ-04`, `SC-02`–`SC-04` | `repositories_spec` | Status, HTML, empty/success, routing negatives | `bin/rspec spec/requests/repositories_spec.rb` | CI default | none | none |

## Open questions / ambiguities

| Open question ID | Question | Why unresolved | Blocks | Default action / escalation owner |
| --- | --- | --- | --- | --- |
| `OQ-01` | none at archive | n/a | none | n/a |

## Environment contract

| Area | Contract | Used by | Failure symptom |
| --- | --- | --- | --- |
| setup | Ruby + Bundler + DB migrate | `STEP-01` | Migration failures |
| test | `bin/rspec` | `STEP-04` | Cannot close `CHK-01` |

## Preconditions

| Precondition ID | Canonical ref | Required state | Used by steps | Blocks start |
| --- | --- | --- | --- | --- |
| `PRE-01` | `ASM-01` | Database available for migrations | `STEP-01` | yes |

## Workstreams

| Workstream | Implements | Result | Owner | Dependencies |
| --- | --- | --- | --- | --- |
| `WS-1` | `REQ-01`, `REQ-02` | Schema + model | agent | `PRE-01` |
| `WS-2` | `REQ-03`, `REQ-04` | Controller + view | agent | `WS-1` |
| `WS-3` | `REQ-05` | Specs | agent | `WS-1`, `WS-2` |

## Approval gates

| Approval gate ID | Trigger | Applies to | Why approval is required | Approver / evidence |
| --- | --- | --- | --- | --- |
| `AG-01` | none | n/a | Local feature only | none |

## Work order

| Step ID | Actor | Implements | Goal | Touchpoints | Artifact | Verifies | Evidence IDs | Check command / procedure | Blocked by | Needs approval | Escalate if |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `STEP-01` | agent | `REQ-01` | Create `repositories` table + index | `db/migrate/*`, `db/schema.rb` | Migration applied | `CHK-01` | `EVID-01` | `bin/rails db:migrate RAILS_ENV=test` | `PRE-01` | none | migrate errors |
| `STEP-02` | agent | `REQ-02` | Model validations | `app/models/repository.rb` | Model | `CHK-01` | `EVID-01` | `bin/rspec spec/models/repository_spec.rb` | `STEP-01` | none | spec failures |
| `STEP-03` | agent | `REQ-03`, `REQ-04` | Index endpoint + ERB | `config/routes.rb`, controller, view | HTML index | `CHK-01` | `EVID-01` | `bin/rspec spec/requests/repositories_spec.rb` | `STEP-02` | none | routing errors |
| `STEP-04` | agent | `REQ-05` | Harden specs (routing negatives, states) | `spec/**/*` | Green suite | `CHK-01` | `EVID-01` | `bin/rspec spec/models/repository_spec.rb spec/requests/repositories_spec.rb` then `bin/rspec` | `STEP-03` | none | regressions |

## Parallelizable work

- `PAR-01` `STEP-02` model specs can follow immediately after `STEP-01`; view/controller (`STEP-03`) waits on model.

## Checkpoints

| Checkpoint ID | Refs | Condition | Evidence IDs |
| --- | --- | --- | --- |
| `CP-01` | `STEP-02` | Model specs green | `EVID-01` |
| `CP-02` | `STEP-04` | Full targeted specs green | `EVID-01` |

## Execution risks

| Risk ID | Risk | Impact | Mitigation | Trigger |
| --- | --- | --- | --- | --- |
| `ER-01` | Unique index mismatch | Data integrity | Match model + DB | First duplicate insert test |

## Stop conditions / fallback

| Stop ID | Related refs | Trigger | Immediate action | Safe fallback state |
| --- | --- | --- | --- | --- |
| `STOP-01` | schema drift | Migration won’t apply | Fix migration | Roll back migration file |

## Ready for acceptance

All steps done; `CHK-01` in `feature.md` satisfied; evidence recorded per `EVID-01`.
