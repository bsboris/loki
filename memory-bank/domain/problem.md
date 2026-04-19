---
title: Project Problem Statement
doc_kind: domain
doc_function: canonical
purpose: Canonical description of the product, problem space, and target outcomes. Read before feature specs so shared context is not repeated in every delivery unit.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Project problem statement

## Agent summary

Short orientation only; authoritative detail is in the sections below.

- **Product:** Git-native translation workspace over YAML i18n (for example Rails `config/locales`); each branch is a workspace; **publish** = commit, push, and PR on the host.
- **Authority:** Git is the single source of truth; **no external TMS**.
- **MVP user flow:** Open → Explore (diff and search) → Edit → Publish.
- **Product non-goals:** No editing translation **structure** (keys/paths), no in-app collaboration threads, no runtime string-delivery product, no dedicated merge UI inside Loki (resolve in Git).
- **Integration:** MVP assumes **GitHub** as the host platform unless a separate initiative says otherwise.

**Loki** is a **Git-native translation workspace** for YAML-based internationalization (for example Rails `config/locales`). It exposes a web UI on top of Git branches: each branch is an isolated **translation workspace**. People edit and review translations in the app; **publishing** means commit, push, and standard pull-request workflow on the host Git platform.

Git is the **single source of truth**. There is **no external TMS** (translation management system); branches, files, and merges remain the authority.

## Boundary with PRD

- `domain/problem.md` — project-wide context: product, users, core workflows, outcomes, and durable constraints.
- `prd/PRD-XXX-short-name.md` — initiative layer: which problem is in scope now, for whom, and with what boundaries.
- If a new document would only repeat this background without initiative-specific scope, do not add a PRD.

## Product summary

Translators and project managers need a place to work on many locale files without learning Git day-to-day, while developers keep owning structure in the repo. Loki bridges that gap: the UI reflects **what changed** versus a base branch, supports **search** over the full tree at a ref, supports **editing** with clear review-oriented state, and ends in **publish** actions that land on a branch and in a PR.

The core workspace concept is: **repository** + **base_ref** + **head_ref** — the translation state on `head_ref`, including differences from `base_ref`. See [`glossary.md`](glossary.md) for definitions.

## Users

### Translator / PM

- Edits and reviews translation **values** for configured locales.
- Does not need Git expertise; uses the UI and PRs on the host.

### Developer

- Owns translation **structure** (keys, paths, file layout) in the repository.
- Reviews and merges translation PRs like any other code change.

## MVP goal

End-to-end workflow:

1. **Open** — open an existing workspace (branch) or create one.
2. **Explore** — see **changed** strings (diff vs base) and **search** across the snapshot at a ref.
3. **Edit** — change translations, see review-oriented status (for example missing / outdated).
4. **Publish** — commit, push, and open or update a PR.

### In scope (product intent)

- GitHub integration for repository metadata and (as implemented) Git operations aligned with the MVP.
- YAML parsing for Rails-style i18n trees.
- Repository-level configuration (scopes, paths, locales) in a config file in the repo.
- Diff between refs, search, editing with review signals, workspace abstraction.

## Core workflows

| Step | What the user does | What the system must support |
| --- | --- | --- |
| Open | Pick or create a branch-backed workspace | Resolve repository, base ref, head ref; load workspace context |
| Explore | Switch between “changed vs base” and full snapshot views | Diff and flattened snapshot at refs; search |
| Edit | Update locale values | Persist drafts; reflect missing/outdated and metadata where modeled |
| Publish | Submit work upstream | Commit + push + PR to the Git remote; merge happens in normal Git flow |

## Non-goals

- Editing translation **structure** (adding/removing keys or paths) from Loki.
- In-app collaboration (comments, threads).
- Runtime delivery (API/CDN for strings to apps in production).
- Dedicated merge/conflict UI inside Loki (users resolve in Git as today).
- Glossary/termbase product.
- Fine-grained permissions beyond what the host and repo already provide.
- Cross-branch automation beyond standard PR practice.

## Constraints

- **Git as SSoT** — branches and files on the remote win; Loki does not replace the repo.
- **No external TMS** — no third-party translation database as authority alongside Git.
- **Host platform** — MVP centers on GitHub; other providers are out of scope until explicitly planned.

## Outcomes

Outcome metrics are not fixed for the MVP documentation pass. When product instrumentation exists, add a small table here (metric, baseline, target, how measured) instead of duplicating it across features.

## Source documents

- Link PRDs, research, or roadmaps here when they exist as separate artifacts.
