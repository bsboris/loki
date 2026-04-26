---
title: Cross-references (code ↔ docs)
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

## Adoption in this repository

Apply the code → docs contract incrementally: add comments at integration boundaries and domain-heavy modules first (Git hosting, repository identity, anything that encodes the aggregates and boundaries in [domain/architecture.md](../domain/architecture.md) or decisions under [adr/index.md](../adr/index.md)). Prefer one accurate link over many shallow ones. When you add or materially change such a module, add or refresh the comment in the same change. Broader coverage is desirable but not a prerequisite for other work.

## Code → docs

A module that implements documented logic contains a comment link to the canonical document.

Minimum contract:

1. The link uses a path relative to the repository root.
2. The annotation explains which aspect of the document is relevant to this module.

## Docs → code (target)

Documentation may link to files and line ranges (once code exists). Each link must be annotated (what is at the link + why read it).
