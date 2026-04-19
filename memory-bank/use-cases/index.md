---
title: Use Cases Index
doc_kind: use_case
doc_function: index
purpose: Navigation for instantiated project use cases. Read to find a canonical product scenario or register a new one.
derived_from:
  - ../dna/governance.md
  - ../flows/templates/use-case/UC-XXX.md
status: active
---

# Use Cases Index

The `memory-bank/use-cases/` directory holds canonical user and operational scenarios for the project.

Use a use case for behavior that lives at product level, repeats over time, and may be upstream for several feature packages. It does not replace `SC-*` inside `feature.md`: `SC-*` are acceptance scenarios for a delivery unit; `UC-*` describe durable system behavior at project level.

## When to add a use case

- a new stable user or operational scenario appears;
- several features implement or change the same flow;
- you need a canonical owner for trigger, preconditions, main flow, and postconditions.

## When a use case is not needed

- the scenario is one-off and lives only inside one feature;
- it is an implementation detail, not a product or operations flow;
- `SC-*` in `feature.md` is enough.

## Registry

*No entries yet — add a row when a `UC-*` file is added under this directory.*

| UC ID | Title | Status | Primary actor | Upstream PRD | Implemented by | Last updated |
| --- | --- | --- | --- | --- | --- | --- |

## Naming

- File format: `UC-XXX-short-name.md`
- Replace `XXX` with a stable project identifier.
- One use case may be upstream for several feature packages.

## Template

- Use [`../flows/templates/use-case/UC-XXX.md`](../flows/templates/use-case/UC-XXX.md)
