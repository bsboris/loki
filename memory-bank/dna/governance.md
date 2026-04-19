---
title: Document governance
doc_kind: governance
doc_function: canonical
purpose: SSoT implementation and dependency-tree rules. Answers: who owns which fact.
derived_from:
  - principles.md
status: active
audience: humans_and_agents
---
# Document governance

A `governed document` is a Markdown file under `memory-bank/` with valid YAML frontmatter. The SSoT principle is defined in [principles.md](principles.md). This document describes how it is applied.

## SSoT implementation

1. Only `active` documents are authoritative. `draft` does not override `active`.
2. Publication status (`status`) is separate from entity lifecycle (`delivery_status`, `decision_status`).

## Source dependency tree

1. The `derived_from` field lists direct upstream documents. Authority flows upstream → downstream.
2. The authority root is `dna/principles.md` and it has no `derived_from`. Every other `active` document must list `derived_from` with at least one upstream path (including `memory-bank/index.md`, which uses `doc_kind: project` and anchors the navigation tree in this file rather than restating governance facts).
3. Cycles are forbidden. Changing upstream may require updating downstream.

## Classification fields (`doc_kind`, `doc_function`)

These fields classify governed Markdown for navigation and authority. The closed **`doc_kind`** vocabulary and **`doc_function`** roles live in [frontmatter.md](frontmatter.md) (sections *Document kind* and *Document role*).

- **DNA and flows** canonicals and indexes should always set both fields consistently with that schema.
- **Domain, engineering, ADR, and delivery docs** use the same fields with the `doc_kind` values listed there; omitting them is discouraged for new documents.
