---
title: Frontmatter schema
doc_kind: governance
doc_function: canonical
purpose: Schema of required and conditional YAML frontmatter fields.
derived_from:
  - governance.md
status: active
audience: humans_and_agents
---
# Frontmatter schema

## Required

| Field | Type | Description |
|---|---|---|
| `status` | enum | `draft` / `active` / `archived` |

## Document kind

Use the **`doc_kind`** field on governed Markdown under `memory-bank/` to classify what the file is about. Stick to this closed set so indexes, agents, and audits stay aligned. If you need a new kind, extend this table and align `memory-bank/dna/governance.md` in the same change.

| Value | Meaning | Typical location |
| --- | --- | --- |
| `governance` | Meta-rules, flows, lifecycle, cross-refs, templates index | `memory-bank/dna/`, `memory-bank/flows/` (process and template indexes) |
| `project` | Repository-wide navigation or context that is not domain product docs | e.g. `memory-bank/index.md` |
| `domain` | Product intent, architecture, glossary | `memory-bank/domain/` |
| `engineering` | How we build and run the app: style, tests, Git, autonomy, local ops | `memory-bank/engineering/`, `memory-bank/ops/` |
| `adr` | Architecture decision records | `memory-bank/adr/` |
| `feature` | Feature packages and feature-shaped templates | `memory-bank/features/`, `memory-bank/flows/templates/feature/` |
| `prd` | Initiative-level requirements | `memory-bank/prd/`, `memory-bank/flows/templates/prd/` |
| `use_case` | Durable user or operational scenarios | `memory-bank/use-cases/`, `memory-bank/flows/templates/use-case/` |

## Document role

The **`doc_function`** field describes how the file participates in the documentation tree.

| Value | Meaning |
| --- | --- |
| `canonical` | Owns facts for its topic; downstream docs link here rather than restating |
| `index` | Table of contents; lists children and when to read them |
| `template` | Governed shape for new documents (often with embedded example frontmatter) |

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
  - path: ../../../adr/ADR-NNN-example-slug.md
    fit: "illustrative only — replace NNN and slug with a real ADR path when recording a dependency"
status: active
---
```
