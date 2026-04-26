---
title: Product Requirements Documents Index
doc_kind: prd
doc_function: index
purpose: Navigation for instantiated project PRDs. Read to find an existing Product Requirements Document or create a new one from the template.
derived_from:
  - ../dna/governance.md
  - ../flows/templates/prd/PRD-XXX.md
status: active
---

# Product Requirements Documents Index

The `memory-bank/prd/` directory holds instantiated project PRDs.

*No PRDs in this directory yet — add `PRD-XXX-*.md` files here when initiatives are instantiated.*

Use a PRD when work lives at product initiative or capability level rather than a single vertical slice. A PRD usually sits between general context in [`../domain/problem.md`](../domain/problem.md) and downstream feature packages in [`../features/index.md`](../features/index.md).

## Boundary with `domain/problem.md`

- [`../domain/problem.md`](../domain/problem.md) stays the project-wide document and is not turned into a PRD.
- A PRD inherits that context via `derived_from` but records only initiative-specific problem, users, goals, and scope.
- If a document would only repeat general project background, stay at `domain/problem.md`.

## When to add a PRD

- the initiative splits into several feature packages;
- users, goals, product scope, and success metrics must be fixed before implementation design;
- there is a risk of mixing product requirements with architecture or design detail.

## When a PRD is not needed

- the task is local and fits entirely in one `feature.md`;
- general product context is already covered by [`../domain/problem.md`](../domain/problem.md) and the feature does not need a separate product-layer document.

## Naming

- File format: `PRD-XXX-short-name.md`
- Replace `XXX` with the project’s stable identifier (initiative id, epic id, or another stable key).
- One PRD may be upstream for several feature packages.

## Template

- Use [`../flows/templates/prd/PRD-XXX.md`](../flows/templates/prd/PRD-XXX.md)
