---
title: "FT-XXX: Feature Template - Short"
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for a short canonical `feature.md` in AI-driven development. Read to instantiate a minimal feature contract without mixing wrapper and target frontmatter.
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

Use this template only if the feature fits one local slice and can be described with `REQ-*`, `NS-*`, one `SC-*`, at most one `CON-*`, one `EC-*`, one `CHK-*`, and one `EVID-*`.

If you need `ASM-*`, `DEC-*`, `CTR-*`, `FM-*`, feature-specific negative cases, more than one acceptance scenario, more than one `CHK-*` / `EVID-*`, or explicit ADR-dependent design logic, upgrade to `large.md` before continuing. Prefix meanings are fixed in [../../feature-flow.md](../../feature-flow.md#stable-identifiers).

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
purpose: "Short canonical feature document for a small, local delivery unit."
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

The specific problem or opportunity this feature addresses.

If an upstream PRD exists, do not restate full product context here; focus on slice-specific problem framing.

If an upstream use case exists, record only how this delivery unit implements or changes that scenario.

### Scope

- `REQ-01` What must be in scope.
- `REQ-02` What else must be in scope.

### Non-scope

- `NS-01` What we explicitly do not do.

### Constraints

- `CON-01` Constraint that bounds the solution.

## How

### Solution

One short paragraph: main approach and key trade-off.

### Change surface

| Surface | Why |
| --- | --- |
| `path/or/component` | Why it changes |

### Flow

1. Input.
2. Processing.
3. Output.

## Verify

### Exit criteria

- `EC-01` What must be true after implementation.

### Acceptance scenarios

- `SC-01` Primary happy path and canonical positive test case for this delivery unit.

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `CON-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `CON-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |

### Checks

Verify must be executable and define at least one explicit test case via `SC-01`.

| Check ID | Covers | How to check | Expected |
| --- | --- | --- | --- |
| `CHK-01` | `EC-01`, `SC-01` | Command or procedure | Expected result |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | `artifacts/ft-xxx/verify/chk-01/` |

### Evidence

- `EVID-01` Artifact that must remain after verification.

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | Minimal verify artifact | verify-runner / human | `artifacts/ft-xxx/verify/chk-01/` | `CHK-01` |
```
