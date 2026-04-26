---
name: start-feature
description: >-
  Boots a GitHub-tracked feature: new branch from main, primed memory-bank reads,
  and a new FT-XXX package (large = brief-first, short = feature.md at bootstrap).
  Use when the user names a GitHub issue id and wants to start implementation with
  governed docs, or says "start new feature", "begin FT-", "bootstrap feature package".
---

# Start Feature

## Inputs (required)

1. **GitHub issue id** — numeric, for example `62` (not the `#` prefix).
2. **Feature flow** — `large` or `short` (aliases: `small` → `short`). **Default: `large`.**

If the user omits the flow, use **`large`**.

## Normalize flow

| User / arg | Path |
| --- | --- |
| `large` | Large path ([`feature-flow.md`](../../../memory-bank/flows/feature-flow.md): `index.md` + `brief.md`; **no** `feature.md` until brief is active) |
| `short`, `small` | Short path: `index.md` + `feature.md`; **no** `brief.md` |

Canonical vocabulary in docs and commits is **short** / **large**; accept **small** only as input.

## Branch and package id

1. **Package directory:** `memory-bank/features/FT-XXX/` where `XXX` is the issue number zero-padded to **3** digits (e.g. `62` → `FT-062`, `7` → `FT-007`). For issue numbers ≥ 1000, use the full decimal issue number without stripping digits (e.g. `1001` → `FT-1001`).
2. **Local branch:** from latest `main`, create `ft-XXX-<short-slug>` (kebab-case, ASCII). Derive `<short-slug>` from the GitHub issue title via `gh issue view <id> --json title` when `gh` is available; otherwise use `issue-<id>`.

## Git steps (no commit)

1. `git fetch origin`
2. `git checkout main` && `git pull origin main` (or equivalent fast-forward; resolve with the human if not fast-forward)
3. If `memory-bank/features/FT-XXX/` **already exists**, stop and report — do not overwrite.
4. `git checkout -b <branch-from-above>`

**Do not** `git add` / `git commit` / `git push` as part of this skill.

## Prime context (read before authoring)

Read enough to avoid contradicting project rules. **Minimum:**

| Order | Path | Why |
| --- | --- | --- |
| 1 | [`memory-bank/index.md`](../../../memory-bank/index.md) | Entry routing |
| 2 | [`memory-bank/flows/feature-flow.md`](../../../memory-bank/flows/feature-flow.md) | Gates, short vs large, stable IDs |
| 3 | [`memory-bank/features/index.md`](../../../memory-bank/features/index.md) | Registration table + naming |

**Strongly suggested** (skim or read sections as relevant):

| Path | Read when |
| --- | --- |
| [`memory-bank/engineering/index.md`](../../../memory-bank/engineering/index.md) | Any code work soon |
| [`memory-bank/engineering/git-workflow.md`](../../../memory-bank/engineering/git-workflow.md) | Branch/PR expectations |
| [`memory-bank/ops/development.md`](../../../memory-bank/ops/development.md) | Local commands / setup |
| [`memory-bank/domain/problem.md`](../../../memory-bank/domain/problem.md) | Product intent / MVP scope |
| [`memory-bank/dna/frontmatter.md`](../../../memory-bank/dna/frontmatter.md) | Frontmatter fields |
| [`memory-bank/engineering/testing-policy.md`](../../../memory-bank/engineering/testing-policy.md) | Verify / tests language |

Defer deeper docs (architecture, ADRs, use cases) until the slice needs them.

## Create the feature package

Templates live under [`memory-bank/flows/templates/feature/`](../../../memory-bank/flows/templates/feature/). Instantiate by copying the **embedded** frontmatter + body from each template (see wrapper notes in the template files); **do not** copy template wrapper YAML at the top of those files.

### Both paths

- Create **`memory-bank/features/FT-XXX/index.md`** from [`index.md`](../../../memory-bank/flows/templates/feature/index.md): replace placeholders, set `title` / `purpose`, add `issue_link` (canonical GitHub issue URL). On **large** path, keep the `brief.md` bullet in the annotated index; on **short** path, **omit** the `brief.md` bullet per template instructions.
- Ensure **`implementation-plan.md` does not exist** at bootstrap.

### Large path only

- Create **`brief.md`** from [`brief.md`](../../../memory-bank/flows/templates/feature/brief.md). Start at **`status: draft`** unless the human already finalized intent. **Do not** create **`feature.md`** yet ([`feature-flow.md`](../../../memory-bank/flows/feature-flow.md) greenfield large path).

### Short path only

- Create **`feature.md`** from [`short.md`](../../../memory-bank/flows/templates/feature/short.md). Start at **`status: draft`**, **`delivery_status: planned`**. **Do not** create **`brief.md`**.

### Registry

- Add a row to the **Registered packages** table in [`memory-bank/features/index.md`](../../../memory-bank/features/index.md): Package, Title (from issue or placeholder), Tracker link, Notes (optional one short phrase).

### Tracker link (human or `gh`)

Per [`feature-flow.md`](../../../memory-bank/flows/feature-flow.md): link the issue to the new `index.md` (and `brief.md` / `feature.md` when they exist).

## Closing output (required)

Print a short block with:

1. **Project status:** current branch; `git status -sb` (or equivalent one-liner).
2. **Feature summary:** issue id + title; flow (`large` / `short`); paths created; reminder that **`feature.md` is intentionally absent** on large path until `brief.md` is active.
3. **Explicit:** working tree changes are **uncommitted** by design.

## Optional improvements (not mandatory)

- Run **`gh issue view <id>`** once and fold **labels / milestone / assignees** into `brief.md` or `feature.md` “Links” / context.
- If the issue body is a spec, **quote or summarize** it in `brief.md` (large) or “Problem” (short), not only the title.
- Note **dependencies** on open PRs or other issues in the package index or brief.
- After bootstrap, if implementation starts immediately: large path → finalize `brief.md` to **`status: active`**, then add **`feature.md`** from [`large.md`](../../../memory-bank/flows/templates/feature/large.md); short path → drive `feature.md` to design-ready per gates, then [`implementation-plan.md`](../../../memory-bank/flows/templates/feature/implementation-plan.md).

## Boilerplate this skill replaces

The human should not need to ask separately to: branch from `main`, look up FT naming, pick short vs large from [`feature-flow.md`](../../../memory-bank/flows/feature-flow.md), find templates, register the package in [`features/index.md`](../../../memory-bank/features/index.md), or restate “do not commit yet.”
