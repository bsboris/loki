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
2. Publication status (`status`) is separate from entity lifecycle (`delivery_status`, `decision_status`).

## Source dependency tree

1. The `derived_from` field lists direct upstream documents. Authority flows upstream → downstream.
2. The root document is `principles.md` and has no `derived_from`. Every other `active` non-root document must have `derived_from`.
3. Cycles are forbidden. Changing upstream may require updating downstream.

## Classification fields (`doc_kind`, `doc_function`)

These fields classify governed Markdown for navigation and authority. The closed **`doc_kind`** vocabulary and **`doc_function`** roles live in [frontmatter.md](frontmatter.md) (sections *Document kind* and *Document role*).

- **DNA and flows** canonicals and indexes should always set both fields consistently with that schema.
- **Domain, engineering, ADR, and delivery docs** use the same fields with the `doc_kind` values listed there; omitting them is discouraged for new documents.
