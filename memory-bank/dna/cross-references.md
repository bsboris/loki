---
doc_kind: governance
doc_function: canonical
purpose: Rules for bidirectional navigation between code and documentation.
derived_from:
  - principles.md
status: active
---
# Cross-references (code ↔ docs)

Goal: keep bidirectional navigation:

- from code to architectural or feature specs;
- from documentation to implementation and tests.

## Code → docs

A module that implements documented logic contains a comment link to the canonical document.

Minimum contract:

1. The link uses a path relative to the repository root.
2. The annotation explains which aspect of the document is relevant to this module.

## Docs → code (target)

Documentation may link to files and line ranges (once code exists). Each link must be annotated (what is at the link + why read it).
