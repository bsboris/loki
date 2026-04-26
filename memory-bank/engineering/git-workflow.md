---
title: Git Workflow
doc_kind: engineering
doc_function: convention
purpose: Loki Git conventions: default branch, commits, and pull requests.
derived_from:
  - ../dna/governance.md
status: active
---

# Git workflow

## Default branch

- **`main`** is the integration branch for Loki.

## Commits

- Use **present tense**, concise subjects (for example: `Add repository default branch to index`).
- Put **why** or non-obvious context in the body when the subject alone would be misleading.
- Reference external trackers only if the project already uses that convention in history.

## Pull requests

- **Green local checks** before opening: at minimum `bin/rspec` and `bin/rubocop` for the touched surface (full suite when the change is broad).
- **Title:** short and specific to the outcome (not “fix stuff” or “updates”).
- **Body:** what changed, how it was verified (commands run), and **risks or manual steps** (migrations, data backfill, feature flags, GitHub setup).

## Worktrees

- Optional for this repo. If you use `git worktree`, run **`bin/setup`** (or the documented subset) in the new tree so gems and databases match the primary checkout.
