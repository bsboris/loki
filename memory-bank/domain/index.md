---
title: Domain Documentation Index
doc_kind: domain
doc_function: index
purpose: Navigation for domain documentation: product problem, architecture, glossary, and deferred frontend notes.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Domain documentation index

Active documents describe **Loki** (Git-native YAML i18n workspace). Use them before duplicating product or architecture background in features or PRDs.

- [`problem.md`](problem.md)
  Canonical product summary, users, MVP goal, workflows (open → explore → edit → publish), non-goals, and constraints (Git as SSoT, no external TMS).
  Read when: you need why Loki exists, who it is for, or what is intentionally out of scope.

- [`architecture.md`](architecture.md)
  Domain data model (repository through diff), module boundaries (Git layer, workspace, YAML, UI), GitHub API failure handling, and repo config ownership.
  Read when: you change integrations, persistence, ref/snapshot/diff behavior, or how configuration is loaded from the repo.

- [`glossary.md`](glossary.md)
  Definitions for workspace, scope, entry, snapshot, diff, missing, outdated, base_ref, and head_ref.
  Read when: you name models, routes, UI labels, or docs and need one spelling and meaning for domain terms.

## Deferred

- [`frontend.md`](frontend.md)
  Placeholder for Hotwire/Turbo/Stimulus and UI conventions when the front end needs its own canonical rules. Stays `status: draft` until populated; promote to `active` when it owns real UI conventions per [Document governance](../dna/governance.md) (*Scaffold until populated*).
  Read when: the UI layer grows enough that layout, components, or client-side i18n need explicit standards beyond engineering and domain docs.
