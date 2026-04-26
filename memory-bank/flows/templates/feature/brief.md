---
title: "FT-XXX: Feature Brief Template"
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for `brief.md`—compact problem formalization before canonical `feature.md` on large slices.
derived_from:
  - ../../feature-flow.md
  - ../../../dna/frontmatter.md
status: active
template_for: feature
template_target_path: ../../../features/FT-XXX/brief.md
---

# FT-XXX: Feature Brief Template

This file describes the wrapper template. The instantiated `brief.md` lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

Use this template **only** when the package uses [`large.md`](large.md) (see [Choosing the `feature.md` template](../../feature-flow.md#choosing-the-featuremd-template) in `feature-flow.md`). Do not create `brief.md` for the short path.

`brief.md` formalizes the problem in prose and bullets. It does **not** own stable verify identifiers (`REQ-*`, `SC-*`, `CHK-*`, …), traceability matrices, or implementation sequence—those belong in `feature.md` and `implementation-plan.md`.

## Instantiated frontmatter

```yaml
title: "FT-XXX: Brief — <short name>"
doc_kind: feature
doc_function: brief
purpose: "Problem formalization for this large feature slice. Read before canonical feature.md when intent is still taking shape."
derived_from:
  - ../../domain/problem.md
  # Optional when upstream exists:
  # - ../../prd/PRD-XXX-short-name.md
  # - ../../use-cases/UC-XXX-short-name.md
status: draft
```

## Instantiated body

```markdown
# FT-XXX: <problem headline>

## Context

Why this slice matters now (forces, deadline, upstream initiative). At most one short paragraph plus optional links: tracker, PRD, ADR, related issues.

## Problem

One tight statement: who is blocked, what fails today, or what opportunity is untapped. **No** solution or stack choices here—only the gap.

## Success

Bullets: observable “good” when this delivery unit is done. Plain language; detailed acceptance moves to `feature.md` as `SC-*` / `CHK-*`.

## Constraints & assumptions

Hard limits (policy, time, compatibility) and working assumptions to validate before design-ready.

## Out of scope (sketch)

What this slice explicitly will not solve (refined as `NS-*` in `feature.md`).

## Open questions

Unknowns that must be answered to lock `feature.md` `What` / `Verify`. (Execution-only unknowns may move to `OQ-*` in `implementation-plan.md` later.)

## Links

- Tracker: <url>
- Related: <paths or urls>
```
