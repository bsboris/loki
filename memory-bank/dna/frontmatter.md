---
title: Frontmatter schema
doc_kind: governance
doc_function: canonical
purpose: Schema of required, recommended, and conditionally required YAML frontmatter fields for governed Markdown.
derived_from:
  - governance.md
status: active
---
# Frontmatter schema

## Required

| Field | Type | Description |
|---|---|---|
| `title` | string | Human-readable document title. Use for navigation and search; align with the document H1 when the body has one. |
| `status` | enum | `draft` (not authoritative—scaffolds until populated; see *Scaffold until populated* in [governance.md](governance.md)) / `active` (authoritative) / `archived` (history only) |
| `derived_from` | list | Direct upstream dependencies (string paths and/or `{path, fit}` objects). **Required** on every governed Markdown file under `memory-bank/` except the authority root [`principles.md`](principles.md), which has no upstream. Matches [governance.md](governance.md) (*Source dependency tree*). |

## Recommended

| Field | Type | Description |
|---|---|---|
| `purpose` | string | One or two sentences: what the document is for and when to read it. Strongly encouraged on indexes and canonicals so readers route without opening the full body. |

## Document kind

Use the **`doc_kind`** field on governed Markdown under `memory-bank/` to classify what the file is about. Stick to this closed set so indexes, agents, and audits stay aligned. If you need a new kind, extend this table and align `memory-bank/dna/governance.md` in the same change.

| Value | Meaning | Typical location |
| --- | --- | --- |
| `governance` | Meta-rules, flows, lifecycle, cross-refs, templates index | `memory-bank/dna/`, `memory-bank/flows/` (process and template indexes) |
| `project` | Repository-wide navigation or context that is not domain product docs | e.g. `memory-bank/index.md` |
| `domain` | Product intent, architecture, glossary | `memory-bank/domain/` |
| `engineering` | How we build the Rails app: style, tests, Git workflow, agent autonomy | `memory-bank/engineering/` |
| `ops` | How we run and operate the app: local development, environments, releases, configuration contracts, runbooks | `memory-bank/ops/` |
| `adr` | Architecture decision records | `memory-bank/adr/` |
| `feature` | Feature packages and feature-shaped templates | `memory-bank/features/`, `memory-bank/flows/templates/feature/` |
| `prd` | Initiative-level requirements | `memory-bank/prd/`, `memory-bank/flows/templates/prd/` |
| `use_case` | Durable user or operational scenarios | `memory-bank/use-cases/`, `memory-bank/flows/templates/use-case/` |

## Document role

The **`doc_function`** field describes how the file participates in the documentation tree.

| Value | Meaning |
| --- | --- |
| `canonical` | Owns facts for its topic; downstream docs link here rather than restating |
| `brief` | Problem formalization for a large feature slice; upstream of canonical `feature.md` for intent; does not own verify IDs or execution sequence |
| `index` | Table of contents; lists children and when to read them |
| `template` | Governed shape for new documents (often with embedded example frontmatter) |

## Conditionally required

| Field | When | Description |
|---|---|---|
| `delivery_status` | Feature documents | `planned` / `in_progress` / `done` / `cancelled` |
| `decision_status` | ADR documents | `proposed` / `accepted` / `superseded` / `rejected` |

## Additional fields

Governed documents may contain fields not listed in this schema. Extra fields do not need to be registered here and are interpreted at the level of the specific `doc_kind` or flow.

## Examples

```yaml
---
title: "FT-XXX: Example feature"
derived_from:
  - ../../domain/problem.md
status: active
delivery_status: planned
purpose: "Illustrates minimal feature frontmatter; replace with a real title and purpose."
---
```

```yaml
---
title: "Example dependency shape"
derived_from:
  - ../feature.md
  - path: ../../../adr/ADR-NNN-example-slug.md
    fit: "illustrative only — replace NNN and slug with a real ADR path when recording a dependency"
status: active
---
```
