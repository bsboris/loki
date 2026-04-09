# Loki

## Product Summary

Loki is a **Git-native translation workspace system** for YAML-based i18n (e.g. Rails).

It provides a web UI on top of Git branches, where each branch acts as an isolated **translation workspace**. Users can edit, review, and publish translations directly via standard PR workflows.

Git is the single source of truth — no external TMS.


## Core Concept

Each workspace is defined by:

- repository
- base_ref
- head_ref

It represents the full translation state of a branch, including diffs vs base.


## MVP Goal

End-to-end workflow:

1. Open or create workspace (branch)
2. Explore translations (diff + full snapshot)
3. Edit translations and review status
4. Publish changes → commit + push + PR

### Includes

- GitHub integration
- YAML (Rails i18n) parsing
- Repo-based configuration
- Diff between branches
- Search across translations
- Editing + review status
- Workspace abstraction


## Users

### Translator / PM
- edits and reviews translations
- no Git required
- works via UI and PRs

### Developer
- manages translation structure in code
- reviews PRs


## Workflow

- Open workspace (existing branch or new)
- View:
  - **Changed** (diff vs base)
  - **Search** (full snapshot)
- Edit translations (draft)
- Publish → commit + push + PR
- Merge via standard Git workflow


## Data Model

**Repository**
- contains translations + config

**Workspace**
- repository, base_ref, head_ref, linked_pr?

**Scope**
- path, source_locale, locales[]

**Entry**
- scope + key_path + locale
- value, source_value
- flags: missing, outdated

**Metadata**
- reviewed, reviewer, reviewed_at

**Snapshot**
- flattened state at ref

**Diff**
- base vs head changes


## Definitions

**Missing**
- no value for a supported locale

**Outdated**
- source changed but translation not updated


## Configuration

Defined in repo config file:
- scopes
- paths
- locales


## Non-Goals

- Editing translation structure (keys, paths)
- Collaboration features (comments, threads)
- Runtime delivery (API/CDN)
- Merge/conflict UI
- Glossary/termbase
- Fine-grained permissions
- Cross-branch automation
