---
title: Architecture Decision Records Index
doc_kind: adr
doc_function: index
purpose: Registry and rules for Architecture Decision Records under memory-bank/adr/. Read to add an ADR or find an accepted decision.
derived_from:
  - ../dna/governance.md
  - ../flows/templates/adr/ADR-XXX.md
status: active
---

# Architecture Decision Records index

This directory holds **instantiated** project ADRs only. Do not store exploratory notes, meeting minutes, or drafts that are not following the ADR shape.

- [`../flows/templates/adr/ADR-XXX.md`](../flows/templates/adr/ADR-XXX.md)
  Governed template (frontmatter contract and section headings) for new ADRs.
  Read when: you need to add a decision record and want the canonical structure and metadata fields.

## Naming

- File name: `ADR-XXX-short-decision-name.md` (three-digit monotonic number, kebab-case slug).
- Numbers are **never reused**; superseded decisions keep their file and gain `decision_status: superseded` plus a pointer to the replacing ADR in the body.
- The `title` in frontmatter should match the human-readable title at the top of the document (including the `ADR-XXX:` prefix).

## Status values

Use `decision_status` in the ADR frontmatter (not only narrative text):

- `proposed` — under review; not treated as canonical for builds or downstream docs yet.
- `accepted` — team treats this as an input to implementation and other documentation.
- `superseded` — replaced by a newer ADR; the replacement must be linked explicitly.
- `rejected` — considered and declined; kept for history.

## Registry

Accepted and in-flight decisions (newest first by number):

- [`ADR-001-git-as-single-source-of-truth.md`](ADR-001-git-as-single-source-of-truth.md)
  Git remains authoritative for locale data; a workspace maps to branch-backed refs; no external TMS.
  Read when: you design persistence, integrations, publish flow, or anything that might duplicate or bypass Git as the system of record.
