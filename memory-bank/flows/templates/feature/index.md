---
title: FT-XXX Feature Index Template
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for feature-level `index.md`. Read to instantiate a bootstrap-safe routing layer for a feature without mixing wrapper metadata and the target index frontmatter.
derived_from:
  - ../../feature-flow.md
  - ../../../dna/frontmatter.md
status: active
template_for: feature
template_target_path: ../../../features/FT-XXX/index.md
---

# FT-XXX Feature Template

This file describes the template wrapper itself. The instantiated feature `index.md` lives below as an embedded contract and is copied into the feature package without wrapper frontmatter and history.

## Wrapper notes

The `memory-bank/flows/templates/feature/` directory holds wrapper templates for the feature package: this directory-index template, [`brief.md`](brief.md) for the large path only, canonical feature templates for short and large features, and the derived template for `implementation-plan.md`. **Short path:** instantiate [`short.md`](short.md) as `feature.md` together with this `index.md`. **Large path (greenfield):** instantiate [`brief.md`](brief.md) and this `index.md` first; do **not** add `feature.md` until `brief.md` is reviewed, finalized, and `status: active` (see [`feature-flow.md`](../../feature-flow.md)), then instantiate [`large.md`](large.md) as `feature.md` and extend the live `index.md` with the `feature.md` route. **Large path (upgrade from short):** follow `feature-flow.md` for ordering when an existing `feature.md` must move to `large.md`. The embedded index must stay bootstrap-safe: list only routes for files that exist; on the large path read `brief.md` before `feature.md` when both exist; on the short path route to `feature.md` only, while optional `implementation-plan.md` and related ADRs are added after those documents exist.

Optional routes for a living feature package are added after the corresponding documents exist. Typical post-bootstrap routes:

- [`implementation-plan.md`](implementation-plan.md)
  Read when: after this file exists, to break down implementation into steps, workstreams, checkpoints, and traceability to canonical IDs.
  Answers: how to run implementation from current state to acceptance.

- [`../../../adr/ADR-XXX.md`](../../../adr/ADR-XXX.md)
  Read when: if there is a related ADR for the feature, to author or verify it with the correct `decision_status`.
  Answers: why a specific architectural or engineering choice applies to the feature and what stage it is in.

## Instantiated frontmatter

```yaml
title: "FT-XXX: Feature Package"
doc_kind: feature
doc_function: index
purpose: "Bootstrap-safe navigation for feature docs. Large path greenfield: `brief.md` may be the only spec file until it is active, then add `feature.md`. Large path: read `brief.md` then `feature.md` when both exist. Short path: read `feature.md` first; add optional derived docs only after they exist."
derived_from:
  - ../../dna/governance.md
  - feature.md
status: active
```

## Instantiated body

```markdown
# FT-XXX: Feature Package

## About this directory

The feature package directory holds canonical `feature.md` once the large-path gates allow it; on the large path it also holds `brief.md` for problem formalization before full `What` / `Verify` in `feature.md`. Optional derived or external routes are added only after the corresponding documents exist. Read in order per the annotated index below.

## Annotated index

- `brief.md` (large path only; omit this bullet from the live index when the package uses `short.md`)
  Read when: first pass on a large slice—before canonical `feature.md` exists, and whenever refreshing intent from prose (after `brief.md` → `status: active`, add `feature.md` from the large template per [`feature-flow.md`](../../flows/feature-flow.md)).
  Answers: context, problem statement, success in plain language, constraints, sketch non-goals, open questions—no stable `REQ-*` / `SC-*` here.

- `feature.md`
  Read when: opening the canonical feature document for scope, design, verify, blockers, and stable IDs (on the large path, only after `brief.md` is `status: active` and this file has been added; when the brief exists, read it before `feature.md`).
  Answers: where scope, design, verify, blockers, and canonical IDs for this feature live.
```
