---
title: Project Problem Statement
doc_kind: domain
doc_function: canonical
purpose: Canonical description of the product, problem space, and target outcomes. Read before feature specs so shared context is not repeated in every delivery unit.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
canonical_for:
  - project_problem_statement
  - product_context
  - top_level_outcomes
---

# Project problem statement

This document captures shared product context for the project. Feature documents should link here instead of repeating the same background.

If a PRD is needed, it does not replace this document; it refines a specific initiative against the project-wide context already recorded here.

## Boundary with PRD

- `domain/problem.md` — project-wide context: product, core workflows, top-level outcomes, and durable constraints.
- `prd/PRD-XXX-short-name.md` — initiative layer: which product problem is in scope now, for which users, and with what scope.
- If a new document would only repeat general project background without initiative-specific scope, do not create a PRD.

## Product context

Describe the project in 2–4 short paragraphs:

- who the primary users are;
- what job the system helps with;
- why the current approach is insufficient;
- product or platform boundaries.

## Core workflows

- `WF-01` Primary user workflow (populate).
- `WF-02` Secondary user workflow (populate).
- `WF-03` Internal or operational workflow that must not break (populate).

## Outcomes

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |

## Constraints

- `PCON-01` Domain constraint that affects most downstream features (populate).
- `PCON-02` Integration, compliance, or performance constraint (populate).

## Source documents

- Add links to PRDs, roadmap, customer research, or other upstream artifacts when they exist.
- If none exist yet, state that explicitly.
