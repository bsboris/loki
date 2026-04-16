---
title: Git Workflow
doc_kind: engineering
doc_function: convention
purpose: Git workflow template. Populate with real branch names, commit rules, and PR expectations for the project.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Git workflow

## Default branch

State which branch is primary (for example `main`, `master`, or a release branch).

## Commits

- Present tense, concise (`fix: normalize cache key`)
- If the project requires issue references in commit messages, state it explicitly
- If auto-close keywords are allowed, list them
- If squash merge is required or forbidden, state it here

## Pull requests

- Canonical local checks must be green before opening a PR
- PR title should be short and specific
- PR body should record what changed, how it was verified, and remaining risks or manual steps

## Worktrees

If the project uses worktrees, document:

- where they are created;
- whether a bootstrap script is required after `git worktree add`;
- which directories are off limits for scratch work.

If worktrees are not used, remove this section when adapting.
