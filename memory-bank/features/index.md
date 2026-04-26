---
title: Feature Packages Index
doc_kind: feature
doc_function: index
purpose: Navigation for instantiated feature packages. Read to find an existing delivery unit or decide where to create a new one.
derived_from:
  - ../dna/governance.md
  - ../flows/feature-flow.md
status: active
---

# Feature Packages Index

The `memory-bank/features/` directory holds instantiated feature packages as `FT-XXX/`.

## Registered packages

| Package | Title | Tracker | Notes |
| --- | --- | --- | --- |
| [`FT-002/`](FT-002/index.md) | Verifiable application startup baseline | [issue #2](https://github.com/bsboris/loki/issues/2) | Root `GET /` + request spec |
| [`FT-004/`](FT-004/index.md) | Repository registration baseline | [issue #4](https://github.com/bsboris/loki/issues/4) | `Repository` + `GET /repositories` index |
| [`FT-008/`](FT-008/index.md) | GitHub repository connection | [issue #8](https://github.com/bsboris/loki/issues/8) | Octokit client + create flow |
| [`FT-062/`](FT-062/index.md) | daisyUI styling system | [issue #62](https://github.com/bsboris/loki/issues/62) | Tailwind plugin + shared partials |

## Rules

- Each package follows [`../flows/feature-flow.md`](../flows/feature-flow.md).
- For bootstrap, use templates under [`../flows/templates/feature/`](../flows/templates/feature/). Large-path greenfield: `index.md` and `brief.md` first; add `feature.md` from `large.md` only after `brief.md` is `status: active`. Short-path packages omit `brief.md`.
- If a feature implements or materially changes a durable project scenario, it must link to the corresponding `UC-*` in [`../use-cases/index.md`](../use-cases/index.md).

## Naming

- Base format: `FT-XXX/`
- Replace `XXX` with the project’s stable identifier (issue id, ticket id, or another stable key).
- One package = one delivery unit.
