---
title: "FT-XXX: Feature Template - Large"
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for an extended canonical `feature.md` in AI-driven development. Defines how to instantiate intent, design, and machine-checkable verify without mixing wrapper and target feature frontmatter.
derived_from:
  - ../../feature-flow.md
  - ../../../dna/frontmatter.md
  - ../../../engineering/testing-policy.md
status: active
template_for: feature
template_target_path: ../../../features/FT-XXX/feature.md
---

# FT-XXX: Feature Name

This file describes the wrapper template. The instantiated `feature.md` lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

Use this template when any `short.md` rule stops holding: the feature touches several surfaces, changes contracts, needs explicit assumptions / blockers, or needs a non-trivial verify layer.

Use stable identifiers from the taxonomy in [../../feature-flow.md#stable-identifiers](../../feature-flow.md#stable-identifiers).

### Frontmatter quick reference

Full schema is in [../../../dna/frontmatter.md](../../../dna/frontmatter.md). For a standard feature, the following is enough:

| Field | Required | Values / default |
|---|---|---|
| `title` | required | `"FT-XXX: Name"` |
| `doc_kind` | required | `feature` |
| `doc_function` | required | `canonical` |
| `purpose` | required | 1–2 sentences |
| `status` | required | `draft` → `active` → `archived` |
| `derived_from` | required for `active` | upstream documents |
| `delivery_status` | required for feature | `planned` → `in_progress` → `done` / `cancelled` |
| `must_not_define` | recommended | what the document does **not** define |

## Instantiated frontmatter

```yaml
title: "FT-XXX: Feature Name"
doc_kind: feature
doc_function: canonical
purpose: "Extended canonical feature document for a complex or multi-layer delivery unit."
derived_from:
  - ../../domain/problem.md
  # Optional:
  # - ../../prd/PRD-XXX-short-name.md
  # - ../../use-cases/UC-XXX-short-name.md
status: draft
delivery_status: planned
must_not_define:
  - implementation_sequence
```

## Instantiated body

```markdown
# FT-XXX: Feature Name

## What

### Problem

Symptom, constraint, or opportunity that makes the feature necessary. If general context is already fixed upstream, describe only the feature-specific delivery question here.

If an upstream PRD exists, this section captures only the feature-specific delta relative to the PRD, not the full product document.

If an upstream use case exists, record the feature-specific change or implementation of that scenario, not the entire project flow.

### Outcome

Describe outcome as a measurable table.

If a numeric success threshold applies only to this delivery unit, record it here. Promote a threshold upstream only after a shared owner exists for several features.

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | What we measure | Starting point | What counts as success | How we verify |

### Scope

- `REQ-01` What must be in the deliverable.
- `REQ-02` What else must be in the deliverable.

### Non-scope

- `NS-01` What is deliberately excluded.
- `NS-02` What the agent must not assume or implement on its own.

### Constraints / assumptions

- `ASM-01` What we rely on now.
- `CON-01` What directly bounds design, rollout, or verify.
- `DEC-01` What is not yet decided and what it blocks.

## How

### Solution

One short paragraph: main technical approach and primary trade-off.

### Change surface

Record where changes are expected.

| Surface | Type | Why it changes |
| --- | --- | --- |
| `path/or/component` | code / config / doc / data | Why it is in the change set |

### Flow

1. What comes in.
2. What the system does.
3. What comes out.

### Contracts

Describe inputs, outputs, events, payloads, or schema changes if they matter for the feature.

| Contract ID | Input / output | Producer / consumer | Notes |
| --- | --- | --- | --- |
| `CTR-01` | What changes | Who writes / who reads | What must hold |

### Failure modes

- `FM-01` What can go wrong.
- `FM-02` How the system should respond.

### ADR dependencies

If the feature depends on an ADR, record it explicitly.

| ADR | Current `decision_status` | Used for | Execution rule |
| --- | --- | --- | --- |
| [../../../adr/ADR-XXX.md](../../../adr/ADR-XXX.md) | `proposed` / `accepted` | Which design choice or baseline | `proposed` is only hypothesis / benchmark candidate, not finalized design; `accepted` is canonical input |

## Verify

`Verify` defines the canonical test case inventory for the delivery unit: positive scenarios via `SC-*`, feature-specific negative coverage via `NEG-*`, executable checks via `CHK-*`, and evidence via `EVID-*`.

### Exit criteria

- `EC-01` Checkable readiness signal.
- `EC-02` Another required readiness signal.

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `ASM-01`, `CON-01`, `DEC-01`, `CTR-01`, `FM-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `ASM-01`, `CON-01`, `CTR-01`, `FM-02` | `EC-02`, `SC-02` | `CHK-01` | `EVID-01` |

### Acceptance scenarios

- `SC-01` Primary happy path.
- `SC-02` Required real-world or edge scenario.

### Checks

Verify must be executable.

| Check ID | Covers | How to check | Expected result | Evidence path |
| --- | --- | --- | --- | --- |
| `CHK-01` | `EC-01`, `SC-01` | Command or procedure | What counts as success | Where the artifact lives |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | `artifacts/ft-xxx/verify/chk-01/` |

### Evidence

- `EVID-01` Artifact that must appear after verification.

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | Log, report, screenshot, or sample output | verify-runner / human | `artifacts/ft-xxx/verify/chk-01/` | `CHK-01` |
```
