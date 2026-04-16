---
doc_kind: governance
doc_function: canonical
purpose: SSoT implementation and dependency-tree rules. Answers: who owns which fact.
derived_from:
  - principles.md
status: active
---
# Document governance

A `governed document` is a Markdown file under `memory-bank/` with valid YAML frontmatter. The SSoT principle is defined in [principles.md](principles.md). This document describes how it is applied.

## SSoT implementation

1. Only `active` documents are authoritative. `draft` does not override `active`.
2. Among documents allowed by status, upstream wins: first `canonical_for`, then the dependency tree.
3. Publication status (`status`) is separate from entity lifecycle (`delivery_status`, `decision_status`).

## Source dependency tree

1. The `derived_from` field lists direct upstream documents. Authority flows upstream → downstream.
2. The root document is `principles.md` and has no `derived_from`. Every other `active` non-root document must have `derived_from`.
3. Cycles are forbidden. Changing upstream may require updating downstream.

## Governance-specific frontmatter fields

Governance documents (DNA, flows) use additional fields outside the common schema ([frontmatter.md](frontmatter.md)):

| Field | Values | Purpose |
| --- | --- | --- |
| `doc_kind` | `governance`, `project` | Document type. Governance = meta-rules; project = domain/ops |
| `doc_function` | `canonical`, `index`, `template` | Role: canonical owner of a fact, navigation index, or template |

These fields are required for governance documents and are not required on domain/ops/engineering documents.
