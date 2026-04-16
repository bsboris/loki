---
title: Feature Packages Index
doc_kind: feature
doc_function: index
purpose: Navigation for instantiated feature packages. Read to find an existing delivery unit or decide where to create a new one.
derived_from:
  - ../dna/governance.md
  - ../flows/feature-flow.md
status: active
audience: humans_and_agents
---

# Feature Packages Index

The `memory-bank/features/` directory holds instantiated feature packages as `FT-XXX/`.

## Rules

- Each package follows [`../flows/feature-flow.md`](../flows/feature-flow.md).
- For bootstrap, use templates under [`../flows/templates/feature/`](../flows/templates/feature/).
- If a feature implements or materially changes a durable project scenario, it must link to the corresponding `UC-*` in [`../use-cases/index.md`](../use-cases/index.md).

## Naming

- Base format: `FT-XXX/`
- Replace `XXX` with the project’s stable identifier (issue id, ticket id, or another stable key).
- One package = one delivery unit.
