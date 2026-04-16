---
title: Template Documentation Index
doc_kind: project
doc_function: index
purpose: Root navigation for the memory-bank template. Read first to understand structure and adaptation points for a concrete project.
status: active
audience: humans_and_agents
---

# Documentation index

The `memory-bank/` directory holds a portable software documentation template. After copying into a downstream repository, adapt `domain/`, `engineering/`, and `ops/` to the real stack, processes, and constraints.

Concrete instantiated examples live in the repository root `examples/` directory (if present).

## Annotated index

- [`domain/index.md`](domain/index.md)
  Read when: capturing product context, architectural boundaries, and UI conventions.

- [`prd/index.md`](prd/index.md)
  Read when: describing a product initiative between the shared problem statement and downstream feature packages.

- [`use-cases/index.md`](use-cases/index.md)
  Read when: registering a durable user or operational scenario for the project.

- [`ops/index.md`](ops/index.md)
  Read when: describing local development, environments, releases, configuration, and runbooks.

- [`engineering/index.md`](engineering/index.md)
  Read when: defining testing policy, coding style, git workflow, and agent autonomy boundaries.

- [`dna/index.md`](dna/index.md)
  Read when: checking SSoT rules, frontmatter contract, and documentation governance.

- [`flows/index.md`](flows/index.md)
  Read when: creating a feature package, moving a feature through lifecycle gates, or using a template.

- [`adr/index.md`](adr/index.md)
  Read when: finding or creating an Architecture Decision Record.

- [`features/index.md`](features/index.md)
  Read when: locating instantiated feature packages.
