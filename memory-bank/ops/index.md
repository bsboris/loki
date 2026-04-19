---
title: Operations Index
doc_kind: ops
doc_function: index
purpose: Navigation for Loki operations docs: local development (active) and deferred staging, release, config, and runbooks.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Operations index

This tree covers day-to-day development for the application in this repository and (when populated) deployment and operations. Prefer this index over duplicating commands in one-off instructions.

## Active

- [`development.md`](development.md)
  Local bootstrap, stack summary, canonical `bin/*` commands, and notes on shells, databases, and `bundle exec` under `CI`.
  Read when: you set up a machine, run the app, execute tests or lint, or need the authoritative command list for agents and humans.

## Deferred

These files stay as translated stubs until the triggers in the memory bank plan apply (staging/prod exists, deployment pipeline, larger env surface, or post-launch incidents). Each uses `status: draft` until it holds real, environment-specific facts; then set `status: active` per [Document governance](../dna/governance.md) (*Scaffold until populated*). Do not treat them as current Loki runbooks while they are draft.

- [`stages.md`](stages.md)
  Non-local environments, access, logs, and smoke checks.
  Read when: staging or production exists and you need documented access and verification steps—not during MVP-only local development.

- [`release.md`](release.md)
  Release process, checklists, and release test plans.
  Read when: a deployment pipeline is in place and you cut or verify releases—not before that.

- [`config.md`](config.md)
  Configuration ownership, naming, and environment contracts.
  Read when: environment variables and config sprawl beyond a handful and need a single reference—not for the small local set documented in development docs.

- [`runbooks/index.md`](runbooks/index.md)
  Incident and operational runbook index.
  Read when: the app is live and you respond to operational incidents or add repeatable recovery steps—not for pre-launch MVP work.
