---
doc_kind: governance
doc_function: canonical
purpose: Schema of required and conditional YAML frontmatter fields.
derived_from:
  - governance.md
status: active
---
# Frontmatter schema

## Required

| Field | Type | Description |
|---|---|---|
| `status` | enum | `draft` / `active` / `archived` |

## Conditionally required

| Field | When | Description |
|---|---|---|
| `derived_from` | Upstream document exists | Direct upstream dependencies. Each entry is a string (path) or object `{path, fit}` where `fit` explains dependency scope |
| `delivery_status` | Feature documents | `planned` / `in_progress` / `done` / `cancelled` |
| `decision_status` | ADR documents | `proposed` / `accepted` / `superseded` / `rejected` |

## Additional fields

Governed documents may contain fields not listed in this schema. Extra fields do not need to be registered here and are interpreted at the level of the specific `doc_kind` or flow.

## Examples

```yaml
---
derived_from:
  - ../../domain/problem.md
status: active
delivery_status: planned
---
```

```yaml
---
derived_from:
  - ../feature.md
  - path: ../../../adr/ADR-001-model-stack.md
    fit: "only selected models and VRAM constraints apply"
status: active
---
```
