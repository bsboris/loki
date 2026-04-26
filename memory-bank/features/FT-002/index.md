---
title: "FT-002: Feature Package"
doc_kind: feature
doc_function: index
purpose: "Bootstrap-safe navigation for the application startup verification feature. Read feature.md first."
derived_from:
  - ../../dna/governance.md
  - feature.md
status: active
issue_link: "https://github.com/bsboris/loki/issues/2"
---

# FT-002: Feature Package

## About this directory

Canonical scope, design, and verification for establishing a verifiable Rails startup baseline (`GET /` returns HTTP 200). Optional execution artifacts live alongside `feature.md`.

## Annotated index

- [`feature.md`](feature.md)
  Read when: you need scope, contracts, acceptance IDs, or evidence for this delivery unit.
  Answers: what must be true for the root route and how it is verified.

- [`implementation-plan.md`](implementation-plan.md)
  Read when: replaying or auditing how this slice was executed (archived record).
  Answers: sequencing, touchpoints, and verify commands used during delivery.
