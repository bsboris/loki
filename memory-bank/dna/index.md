---
title: DNA Documentation Index
doc_kind: governance
doc_function: index
purpose: Entry point into DNA — table of contents for governance documents.
derived_from:
  - principles.md
status: active
audience: humans_and_agents
---

# DNA index

DNA is the constitution of project documentation. It defines principles, documentation rules, frontmatter schema, and lifecycle.

- [`principles.md`](principles.md)
  Foundational principles: SSoT, atomicity, progressive disclosure.
  Read when: you need the authority root for documentation rules or must resolve what “canonical” means before editing governed Markdown.

- [`governance.md`](governance.md)
  SSoT implementation, dependency tree, scaffold vs active rules.
  Read when: you edit memory-bank structure, `derived_from`, or `status`, or need to know who owns each class of fact.

- [`frontmatter.md`](frontmatter.md)
  Required and conditional YAML fields, `doc_kind`, and `doc_function` vocabulary.
  Read when: you add or change frontmatter on governed files or need the closed kind/role sets.

- [`lifecycle.md`](lifecycle.md)
  Maintenance rules and sync checklist for keeping docs true as the code changes.
  Read when: you update docs alongside code, notice drift, or must decide whether to fix upstream vs report.

- [`cross-references.md`](cross-references.md)
  Rules for bidirectional navigation between code and docs.
  Read when: you add doc links from the codebase, wire ADRs to implementation, or align comments with memory-bank anchors.
