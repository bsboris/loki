---
title: Autonomy Boundaries
doc_kind: engineering
doc_function: canonical
purpose: Loki agent and automation boundaries: safe autopilot, checkpoints, and escalation.
derived_from:
  - ../dna/governance.md
canonical_for:
  - agent_autonomy_rules
  - escalation_triggers
  - supervision_checkpoints
status: active
audience: humans_and_agents
---

# Autonomy boundaries

These rules apply to **Loki** development: Rails + PostgreSQL, Git-backed i18n workspaces, and **GitHub** as the primary integration for repository metadata and API calls.

## Autopilot — no confirmation required

- **Edit application code** within the agreed task scope (Ruby, Rails views, Stimulus, Tailwind, config that is clearly local to the change).
- **Run tests and lint:** `bin/rspec`, `bin/rubocop`, and other project scripts requested for verification.
- **Create branches and local Git state** (commits, rebases) that stay on the developer machine and do not affect shared branches without an explicit checkpoint below.
- **Read logs and diagnostics** (test output, Rails logs, local stack traces).
- **Update internal documentation**, including files under `memory-bank/`, when that is part of the task or required to keep docs truthful after a code change.

## Supervision — proceed, but surface a checkpoint

- **Database migrations and schema changes:** show the migration and rollback story before applying on shared environments; never assume production data is disposable.
- **Architectural shifts** (new boundaries between Git, workspace, YAML, or GitHub layers; new persisted concepts): outline the plan and trade-offs before large edits.
- **Pull requests to `main`:** summarize the diff, test results, and risks; do not merge without the project’s normal review bar.
- **Routing, auth, or deployment contract changes:** show the diff and impact on operators or users.
- **Deleting code, files, or features:** list what is removed and why, including any follow-up for callers or docs.

## Escalation — stop and ask

- **Unclear or conflicting requirements** (product behavior, locale rules, Git edge cases).
- **GitHub integration changes** that affect **authentication**, **token scopes**, **rate limits**, or **webhooks**—these have security and operational blast radius.
- **Any production action** or mutation of live customer data, secrets, or remote repositories outside a clearly scoped sandbox.
- **Choosing between valid designs** with materially different trade-offs (e.g., new sync model vs incremental fetch) without a recorded decision.
- **Conflicting patterns in the codebase**—do not guess which path is canonical; align with owners or existing ADRs.
- **Scope creep:** do not expand the task silently when new work appears mid-flight.

## Escalation rule

If feedback or errors do not shrink after **two to three** focused iterations, treat the issue as potentially **requirements, plan, or environment**—not another blind coding loop. Pause, restate assumptions, and propose returning to clarification or design before more changes.
