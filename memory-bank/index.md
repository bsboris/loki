---
title: Loki Memory Bank
doc_kind: project
doc_function: index
purpose: Single navigation entry point for humans and agents into Loki documentation under memory-bank/.
status: active
audience: humans_and_agents
---

# Memory bank index

**Loki** is a Git-native translation workspace for YAML-based internationalization. Use this file first to find product context, engineering rules, operations, ADRs, workflows, and DNA.

## Active sections

- [`domain/index.md`](domain/index.md)
  Domain vocabulary, problem statement, architecture, and glossary for Git-centric YAML i18n.
  Read when: you need product intent, canonical terms, or system boundaries before changing behavior or data that users see.

- [`engineering/index.md`](engineering/index.md)
  Coding style, testing policy, Git workflow, and autonomy boundaries for the Rails application.
  Read when: you write or review code, run tests and lint, branch or open PRs, or decide what an automated agent may do without asking.

- [`ops/index.md`](ops/index.md)
  Operations index; local development is covered in `development.md` for the current MVP.
  Read when: you bootstrap the environment, run the app, or need the canonical commands for tests and lint.

- [`dna/index.md`](dna/index.md)
  Documentation DNA: principles first; deeper governance files are deferred until the project needs them.
  Read when: you align work with documentation principles or navigate the constitution of this memory bank.

- [`adr/index.md`](adr/index.md)
  Architecture Decision Records: registry, naming, and status rules for accepted technical decisions.
  Read when: you record, supersede, or look up a durable architectural choice that affects how Loki is built.

- [`flows/index.md`](flows/index.md)
  Lifecycle flows and governed templates for features, PRDs, use cases, and ADRs.
  Read when: you create a feature package, move work through lifecycle gates, or copy a governed template.

## Deferred sections

Content in these paths is intentionally minimal until the trigger condition applies. Prefer active sections above unless the condition matches your work.

- [`prd/index.md`](prd/index.md)
  Product-requirements hub for initiatives larger than a single problem statement.
  Read when: you are planning a V2 initiative that spans multiple feature packages.

- [`use-cases/index.md`](use-cases/index.md)
  Registry for durable user and operational scenarios.
  Read when: core flows (open, explore, edit, publish) are stable enough to canonicalize.

- [`features/index.md`](features/index.md)
  Parallel feature backlog beyond a single focused sprint.
  Read when: you are tracking a parallel backlog beyond a single focused sprint.

### Operations (deferred topics)

These files exist under `ops/` but are not maintained for the current MVP; use the operations entry under Active sections as the parent index.

- [`ops/stages.md`](ops/stages.md)
  Staging and production environments, access, logs, and smoke checks.
  Read when: a staging or production environment exists.

- [`ops/release.md`](ops/release.md)
  Release process, checklists, and release test plans.
  Read when: a deployment pipeline is in place.

- [`ops/config.md`](ops/config.md)
  Configuration ownership, naming, and environment contract.
  Read when: environment variables and configuration grow beyond a handful.

- [`ops/runbooks/index.md`](ops/runbooks/index.md)
  Structure for operational runbooks and incident instructions.
  Read when: the product is post-launch and you are responding to or preventing operational incidents.

### Domain (deferred file)

- [`domain/frontend.md`](domain/frontend.md)
  Hotwire, Turbo, Stimulus, and UI-layer conventions.
  Read when: the front-end stack needs explicit conventions beyond what engineering and domain docs already imply.

### DNA (deferred detail)

Meta-governance for large documentation sets. Principles stay under the DNA entry in Active sections until these files are activated.

- [`dna/governance.md`](dna/governance.md)
  Single source of truth rules and documentation dependency tree.
  Read when: documentation volume makes meta-governance and ownership rules worth maintaining explicitly.

- [`dna/frontmatter.md`](dna/frontmatter.md)
  Frontmatter field schema for memory-bank documents.
  Read when: documentation volume makes meta-governance and ownership rules worth maintaining explicitly.

- [`dna/lifecycle.md`](dna/lifecycle.md)
  Maintenance rules and sync checklist for documentation.
  Read when: documentation volume makes meta-governance and ownership rules worth maintaining explicitly.

- [`dna/cross-references.md`](dna/cross-references.md)
  Bidirectional navigation between code and documentation.
  Read when: documentation volume makes meta-governance and ownership rules worth maintaining explicitly.
