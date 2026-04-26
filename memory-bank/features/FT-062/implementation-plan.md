---
title: "FT-062: Implementation Plan"
doc_kind: feature
doc_function: derived
purpose: "Archived execution plan for daisyUI packages, Tailwind config, shared partials, and page adoption."
derived_from:
  - feature.md
status: archived
must_not_define:
  - ft_062_scope
  - ft_062_architecture
  - ft_062_acceptance_criteria
  - ft_062_blocker_state
---

# Implementation plan

## Plan goal

Integrate daisyUI, add shared alert/card partials, and adopt them on layout, home, and repositories index with RSpec proof.

## Current state / reference points

| Path / module | Current role | Why relevant | Reuse / mirror |
| --- | --- | --- | --- |
| `app/assets/tailwind/application.css` | Tailwind entry | Plugin wiring | Extend, don’t replace pipeline |
| `app/views/layouts/application.html.erb` | Global shell | Theme + flash | daisyUI theme on `html` |
| `bin/setup` | Bootstrap | npm install | Must install frontend deps |
| `package.json` | Node deps | daisyUI version | Lockfile committed |

## Test strategy

| Test surface | Canonical refs | Existing coverage | Planned automated coverage | Required local suites / commands | Required CI suites / jobs | Manual-only gap / justification | Manual-only approval ref |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Partials | `REQ-03`, `SC-04` | view specs under `spec/views/shared/ui` | Class hooks + locals | `bin/rspec spec/views/shared/ui` | CI | none | none |
| Pages | `REQ-04`, `SC-02`, `SC-03` | home + repositories request specs | 200/HTML + markup | `bin/rspec spec/requests/home_spec.rb spec/requests/repositories_spec.rb` | CI | none | none |
| Display helper | `REQ-04` | optional model spec | If helper on `Repository` | `bin/rspec spec/models/repository_spec.rb` | CI | none | none |

## Open questions / ambiguities

| Open question ID | Question | Why unresolved | Blocks | Default action / escalation owner |
| --- | --- | --- | --- | --- |
| `OQ-01` | none at archive | n/a | none | n/a |

## Environment contract

| Area | Contract | Used by | Failure symptom |
| --- | --- | --- | --- |
| setup | Node + npm ci/install per `bin/setup` | CSS build | Missing daisyUI classes |
| test | `bin/rspec` | all steps | Verify fails |

## Preconditions

| Precondition ID | Canonical ref | Required state | Used by steps | Blocks start |
| --- | --- | --- | --- | --- |
| `PRE-01` | `ASM-01` | Tailwind build path works | `STEP-01` | yes |

## Workstreams

| Workstream | Implements | Result | Owner | Dependencies |
| --- | --- | --- | --- | --- |
| `WS-1` | `REQ-01`, `REQ-02` | Packages + theme | agent | `PRE-01` |
| `WS-2` | `REQ-03` | Partials | agent | `WS-1` |
| `WS-3` | `REQ-04` | Page adoption | agent | `WS-2` |
| `WS-4` | `REQ-05` | Specs | agent | `WS-3` |

## Approval gates

| Approval gate ID | Trigger | Applies to | Why approval is required | Approver / evidence |
| --- | --- | --- | --- | --- |
| `AG-01` | none | n/a | No external prod change | none |

## Work order

| Step ID | Actor | Implements | Goal | Touchpoints | Artifact | Verifies | Evidence IDs | Check command / procedure | Blocked by | Needs approval | Escalate if |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `STEP-01` | agent | `REQ-01`, `REQ-02` | daisyUI dependency + Tailwind config + theme | `package.json`, lockfile, `bin/setup`, `.gitignore`, `application.css` | Built CSS includes plugin | `CHK-01` | `EVID-01` | `bin/dev` or asset build smoke per ops docs | `PRE-01` | none | build failure |
| `STEP-02` | agent | `REQ-03` | Shared partials | `app/views/shared/ui/*` | Partials render classes | `CHK-01` | `EVID-01` | `bin/rspec spec/views/shared/ui` | `STEP-01` | none | spec failures |
| `STEP-03` | agent | `REQ-04` | Layout + home + repositories markup | layout, `home/index`, `repositories/index`, optional model helper | Pages match UX spec | `CHK-01` | `EVID-01` | Request specs | `STEP-02` | none | regressions |
| `STEP-04` | agent | `REQ-05` | Full targeted + suite | `spec/**/*` | Green CI | `CHK-01` | `EVID-01` | `bin/rspec` + `bin/rubocop` | `STEP-03` | none | CI red |

## Parallelizable work

- `PAR-01` View specs for partials (`STEP-02`) can run in parallel with final layout tweaks only if no shared file conflicts—default sequential to reduce churn.

## Checkpoints

| Checkpoint ID | Refs | Condition | Evidence IDs |
| --- | --- | --- | --- |
| `CP-01` | `STEP-02` | Partial specs green | `EVID-01` |
| `CP-02` | `STEP-04` | Full verify green | `EVID-01` |

## Execution risks

| Risk ID | Risk | Impact | Mitigation | Trigger |
| --- | --- | --- | --- | --- |
| `ER-01` | Asset pipeline drift | Missing styles | Follow existing Tailwind entry | CI request spec sees no `card` class |

## Stop conditions / fallback

| Stop ID | Related refs | Trigger | Immediate action | Safe fallback state |
| --- | --- | --- | --- | --- |
| `STOP-01` | build | Cannot compile CSS | Stop feature; fix packages | Revert package changes |

## Ready for acceptance

Pages and partials match `feature.md`; `CHK-01` satisfied; evidence paths populated.
