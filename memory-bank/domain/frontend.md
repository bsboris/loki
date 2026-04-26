---
title: Frontend
doc_kind: domain
doc_function: canonical
purpose: Placeholder for UI surfaces, design system, and i18n layer. Read when working on web, mobile, or internal UI conventions.
derived_from:
  - ../dna/governance.md
status: draft
---

# Frontend

This document should describe real UI surfaces for the product when the Hotwire/Turbo/Stimulus layer needs explicit conventions. Until then, keep this file minimal.

## UI surfaces

For each surface, record when populated:

- where code lives;
- stack in use;
- boundary with backend;
- canonical owner for design decisions.

## Component and styling rules

Record when populated:

- whether a shared design system exists;
- where shared components live;
- whether ad hoc UI without shared components is allowed;
- who owns theme tokens, spacing, typography, and states.

## Interaction patterns

Record the canonical interactivity pattern for the project (for example server-rendered UI, SPA, islands, Hotwire/Turbo).

## Localization

Record when populated:

- where translations come from;
- how they reach the UI;
- caching or versioning;
- how new keys are added and who owns fallback behavior.

If multiple translation sources exist, record priority and merge order.
