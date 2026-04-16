---
title: Architecture Decision Records Index
doc_kind: adr
doc_function: index
purpose: Navigation for project ADRs. Read to find accepted decisions or create a new ADR from the template.
derived_from:
  - ../dna/governance.md
  - ../flows/templates/adr/ADR-XXX.md
status: active
audience: humans_and_agents
---

# Architecture Decision Records index

The `memory-bank/adr/` directory holds instantiated project ADRs.

- Create new ADRs from [`../flows/templates/adr/ADR-XXX.md`](../flows/templates/adr/ADR-XXX.md).
- Keep only real decision records in this directory, not notes or exploratory drafts.
- If there are no ADRs yet, this index remains the expected location for future decisions.

## Naming

- File format: `ADR-XXX-short-decision-name.md`
- Use monotonic numbering; do not reuse numbers
- The file title should match `title` in frontmatter

## Statuses

- `proposed` — decision drafted but not accepted
- `accepted` — decision accepted and treated as canonical input for downstream documents
- `superseded` — decision replaced by another ADR
- `rejected` — decision considered and declined
