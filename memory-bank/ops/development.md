---
title: Development Environment
doc_kind: engineering
doc_function: canonical
purpose: Local development template. Populate with real setup, dev commands, and browser/database workflow for the project.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Development environment

Replace placeholders below with real project commands.

## Setup

Minimum environment preparation (commands, tools, services).

## Daily commands

Canonical local commands the agent should know (dev server, test, lint).

## Browser testing

If the project has a UI, document:

- how to determine the local URL;
- where port or host come from;
- whether they can be discovered automatically;
- which browser verification approaches are canonical.

## Database and services

Document only what matters locally:

- migrations;
- resetting the local database;
- required services;
- seeded data;
- known pitfalls for developers and agents.

## Adoption checklist

- [ ] real setup commands recorded
- [ ] real test/lint commands recorded
- [ ] local URL discovery documented
- [ ] local dependencies and services listed
- [ ] irrelevant examples removed
