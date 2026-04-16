---
title: FT-XXX Feature Template - Implementation Plan
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for an implementation plan. Defines how to instantiate an execution document without redefining scope, architecture, or acceptance criteria, and without mixing wrapper metadata with target `implementation-plan.md`.
derived_from:
  - ../../feature-flow.md
  - ../../../dna/frontmatter.md
  - ../../../engineering/testing-policy.md
status: active
audience: humans_and_agents
template_for: feature
template_target_path: ../../../features/FT-XXX/implementation-plan.md
---

# Implementation plan

This file describes the wrapper template. The instantiated `implementation-plan.md` lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

Requirements, design, blocker state, and acceptance criteria live in sibling `feature.md`. This document only defines work sequencing and execution checkpoints.
In the feature package being created, sibling `feature.md` must be instantiated from the canonical feature template in `memory-bank/flows/templates/feature/`.

Create this document only after sibling `feature.md` is moved to `status: active`. While the plan is still being shaped, `implementation-plan.md` may stay `status: draft`; before the feature moves to `delivery_status: in_progress`, the plan must become `status: active`.

When the feature moves to `delivery_status: done` or `delivery_status: cancelled`, archive `implementation-plan.md` if it is no longer used as a working execution document.

The document must be executable without extra interpretation. If a step cannot be tied to canonical IDs, an artifact, a check, or an explicit manual procedure, the step is underspecified.
The plan must be grounded in the current repository state: first record relevant modules, local patterns, open questions, and execution environment, then sequence changes.
The plan must explicitly record which automated tests will be added or updated for the change surface, which suites must be green locally and in CI, and which gaps remain temporarily manual-only with justification and approval ref.

For links inside the plan, use stable identifiers from the taxonomy in [../../feature-flow.md#stable-identifiers](../../feature-flow.md#stable-identifiers).

If an unknown changes scope, architecture, acceptance criteria, blocker state, or the evidence contract, raise it upstream in sibling `feature.md` or the ADR first, then reflect it in the plan.

## Instantiated frontmatter

```yaml
title: "FT-XXX: Implementation Plan"
doc_kind: feature
doc_function: derived
purpose: "Execution plan for FT-XXX. Records discovery context, steps, risks, and test strategy without redefining canonical feature facts."
derived_from:
  - feature.md
status: draft
audience: humans_and_agents
must_not_define:
  - ft_xxx_scope
  - ft_xxx_architecture
  - ft_xxx_acceptance_criteria
  - ft_xxx_blocker_state
```

## Instantiated body

```markdown
# Implementation plan

## Plan goal

Delivery outcome this plan should produce.

## Current state / reference points

Existing files, modules, commands, or documents the agent must study before changes. This section records grounding in the current repository state and local patterns that must not be ignored.

| Path / module | Current role | Why relevant | Reuse / mirror |
| --- | --- | --- | --- |
| `path/to/module` | What this artifact already does | Why planning is wrong without it | Pattern, helper, command, or contract to repeat |

## Test strategy

Test surfaces that should be updated during implementation. This section records expected automated coverage, required local/CI gates, and manual-only exceptions for the change surface, without redefining canonical test cases from `feature.md`.

| Test surface | Canonical refs | Existing coverage | Planned automated coverage | Required local suites / commands | Required CI suites / jobs | Manual-only gap / justification | Manual-only approval ref |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `path/or/behavior` | `REQ-01`, `SC-01`, `NEG-01`, `CHK-01` | What is covered now | Suite, test type, or deterministic check to add or update | Commands or suites that must be green locally | Jobs or suites that must be green in CI | What stays manual-only and why | `AG-01` / review link / `none` |

## Open questions / ambiguities

Unknowns not yet resolved after discovery. If a question changes upstream semantics, it must not be silently resolved inside an execution step.

| Open question ID | Question | Why unresolved | Blocks | Default action / escalation owner |
| --- | --- | --- | --- | --- |
| `OQ-01` | What is unknown | Why it is not yet proven | `STEP-02` / `WS-1` / whole plan | Default action and who decides on escalation |

## Environment contract

Execution environment considered valid for the plan: setup, test commands, env vars, permissions, mocks, external dependencies, and other operational assumptions.

| Area | Contract | Used by | Failure symptom |
| --- | --- | --- | --- |
| setup | Required environment prep | `STEP-01`, `STEP-02` | Symptom of invalid environment |
| test | Command or procedure treated as canonical for verify at this stage | `CHK-01` | When verify is unreliable |
| access / network / secrets | Access, domains, keys, or sandbox assumptions | `STEP-03` | When work must stop and escalate |

## Preconditions

What must be ready before work starts: data, access, ADR, environment, agreements. Each row references a canonical ref and does not paraphrase its meaning.

| Precondition ID | Canonical ref | Required state | Used by steps | Blocks start |
| --- | --- | --- | --- | --- |
| `PRE-01` | `ASM-01` / `DEC-01` / `CON-01` / ADR path | Upstream state acceptable to start | `STEP-01`, `STEP-02` | yes / no |

## Workstreams

Split work into independent streams with an explicit result each.

| Workstream | Implements | Result | Owner | Dependencies |
| --- | --- | --- | --- | --- |
| `WS-1` | `REQ-01`, `CTR-01` | What must appear | human / agent / either | What blocks start or completion |

## Approval gates

Actions that must not run without explicit human confirmation. Use for risky, irreversible, costly, or externally visible operations.

| Approval gate ID | Trigger | Applies to | Why approval is required | Approver / evidence |
| --- | --- | --- | --- | --- |
| `AG-01` | Which step or symptom requests approval | `STEP-03` / `WS-2` | Why autonomous continuation is unsafe | Who confirms and how it is recorded |

## Work order

Describe execution as atomic steps. Each step must be small enough to verify and, if needed, roll back or stop without the change surface spreading.

| Step ID | Actor | Implements | Goal | Touchpoints | Artifact | Verifies | Evidence IDs | Check command / procedure | Blocked by | Needs approval | Escalate if |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `STEP-01` | human / agent / either | `REQ-01`, `REQ-02`, `CTR-01` | What this step does | Files, services, or data touched | What must exist after the step | `CHK-01` | `EVID-01` | How completion is confirmed | `PRE-01`, `OQ-01` | `AG-01` / `none` | When to stop without escalation |

## Parallelizable work

Steps or workstreams that can run in parallel without change-surface conflict.

- `PAR-01` What may run in parallel.
- `PAR-02` What must not be parallelized due to shared write surface.

## Checkpoints

Intermediate points that must be passed before rollout or handoff.

| Checkpoint ID | Refs | Condition | Evidence IDs |
| --- | --- | --- | --- |
| `CP-01` | `STEP-01`, `CHK-01` | Intermediate state that must be proven | `EVID-01` |

## Execution risks

Practical risks that can break schedule or force plan rebuild.

| Risk ID | Risk | Impact | Mitigation | Trigger |
| --- | --- | --- | --- | --- |
| `ER-01` | What can go wrong | What it breaks | What we do upfront | Signal that activates mitigation |

## Stop conditions / fallback

When the plan must stop or roll back to a safe state.

| Stop ID | Related refs | Trigger | Immediate action | Safe fallback state |
| --- | --- | --- | --- | --- |
| `STOP-01` | `DEC-01`, `RJ-01` | Symptom that triggers stop | What to do immediately | State to roll back to or freeze |

## Ready for acceptance

Conditions that must hold to treat the plan as exhausted and move to final acceptance per the `Verify` section in sibling `feature.md`.
```
