---
title: Templates Index
doc_kind: governance
doc_function: index
purpose: Navigation for reference project documentation templates. Read to add a new feature, ADR, or execution document without inventing a new structure.
derived_from:
  - ../../dna/governance.md
  - prd/PRD-XXX.md
  - use-case/UC-XXX.md
  - feature/index.md
  - feature/implementation-plan.md
  - feature/short.md
  - feature/large.md
  - adr/ADR-XXX.md
status: active
---

# Templates Index

The `memory-bank/flows/templates/` directory holds reference documentation templates. All templates exist as governed wrapper documents with `doc_function: template`: the wrapper has its own purpose, while frontmatter and body of the instantiated document live inside the embedded template contract.

- [PRD-XXX: Product Initiative Name](prd/PRD-XXX.md) — compact Product Requirements Document for an initiative not yet decomposed into a single feature slice.
- [UC-XXX: Use Case Name](use-case/UC-XXX.md) — canonical use case for a durable user or operational scenario.
- [FT-XXX Feature Index Template](feature/index.md) — directory index template (`index.md`) for a feature package. Answers: how to structure the feature-level routing document.
- [FT-XXX: Feature Template - Short](feature/short.md) — minimal canonical feature for a small feature. Answers: what a short feature document looks like.
- [FT-XXX: Feature Template - Large](feature/large.md) — canonical feature with assumptions, blockers, contracts, and verify layer. Answers: what a large feature document looks like.
- [FT-XXX: Implementation Plan](feature/implementation-plan.md) — derived execution plan template. Answers: how to structure sequencing and checkpoints.
- [ADR-XXX: Short Decision Name](adr/ADR-XXX.md) — ADR template. Answers: how to record an architectural decision.
