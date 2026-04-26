---
name: git-cleanup-after-feature
description: "After a merged PR: capture branch name, verify merge, checkout main, pull, delete local feature branch (handles squash merges)."
disable-model-invocation: true
---

# Git Cleanup After Feature

## Overview

Clean up **local** Git state after a feature PR is merged: switch to `main`, fast-forward from `origin`, remove the feature branch. Assumes default branch is **`main`**; adjust if the repo uses `master`.

## When to use

- The PR for this work is **already merged** (or you have confirmed the same commits are on `main`).
- You want a tidy tree: latest `main`, no stale local feature branch.

## Do not use

- PR is still open or you are not sure the work landed on `main` — verify first.

## Instructions (for the agent)

1. **Capture the feature branch name before any checkout**
   `FEATURE_BRANCH=$(git rev-parse --abbrev-ref HEAD)`
   If `FEATURE_BRANCH` is `main` or `master`, stop and ask the human for the feature branch name, or have them check out that branch and run again.

2. **Confirm the PR is merged** (GitHub repos with `gh`)
   `gh pr view --head "$FEATURE_BRANCH" --json state,mergedAt`
   - If `state` is `MERGED`, continue.
   - If `OPEN` or no PR: stop and warn — do not delete the branch.
   - If `gh` is unavailable, ask the human to confirm merge in the browser, then continue only after explicit yes.

3. **Update local `main`**
   `git fetch origin`
   `git checkout main`
   `git pull origin main`
   (Resolve any pull issues with the human before deleting anything.)

4. **Delete the local feature branch**
   - Try: `git branch -d "$FEATURE_BRANCH"`
   - If Git reports “not fully merged” **and** step 2 confirmed merged: this is normal for **squash** or **rebase** merges. Then run: `git branch -D "$FEATURE_BRANCH"`
   - If `-d` failed and merge was **not** confirmed: do **not** use `-D`; stop and investigate.

5. **Optional hygiene**
   `git remote prune origin` — clears stale remote-tracking branches (e.g. after “delete branch” on merge).
