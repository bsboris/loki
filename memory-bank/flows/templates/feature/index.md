---
title: FT-XXX Feature README Template
doc_kind: feature
doc_function: template
purpose: Governed wrapper template for feature-level `README.md`. Read to instantiate a bootstrap-safe routing layer for a feature without mixing wrapper metadata and the target README frontmatter.
derived_from:
  - ../../feature-flow.md
  - ../../../dna/frontmatter.md
status: active
audience: humans_and_agents
template_for: feature
template_target_path: ../../../features/FT-XXX/README.md
---

# FT-XXX Feature Template

This file describes the template wrapper itself. The instantiated feature README lives below as an embedded contract and is copied into the feature package without wrapper frontmatter and history.

## Wrapper notes

The `memory-bank/flows/templates/feature/` directory holds wrapper templates for the feature package: this README template, canonical feature templates for short and large features, and the derived template for `implementation-plan.md`. When creating a new feature package, the embedded README must stay bootstrap-safe: it first routes only to instantiated `feature.md`, while optional `implementation-plan.md` and related ADRs are added after those documents exist.

Optional routes for a living feature package are added after the corresponding documents exist. Typical post-bootstrap routes:

- [`implementation-plan.md`](implementation-plan.md)
  Read when: after this file exists, to break down implementation into steps, workstreams, checkpoints, and traceability to canonical IDs.
  Answers: how to run implementation from current state to acceptance.

- `../../../adr/ADR-XXX.md`
  Read when: if there is a related ADR for the feature, to author or verify it with the correct `decision_status`.
  Answers: why a specific architectural or engineering choice applies to the feature and what stage it is in.

## Instantiated frontmatter

```yaml
title: "FT-XXX: Feature Package"
doc_kind: feature
doc_function: index
purpose: "Bootstrap-safe navigation for feature docs. Read to go to canonical `feature.md` first; add optional derived docs only after they exist."
derived_from:
  - ../../dna/governance.md
  - feature.md
status: active
audience: humans_and_agents
```

## Instantiated body

```markdown
# FT-XXX: Feature Package

## About this directory

The feature package directory holds canonical `feature.md`; optional derived or external routes are added only after the corresponding documents exist. Read `feature.md` first, then extend routing as execution and decision artifacts appear.

## Annotated index

- [`feature.md`](feature.md)
  Read when: open the instantiated canonical feature document right after bootstrapping a new feature package.
  Answers: where scope, design, verify, blockers, and canonical IDs for this feature live.
```
