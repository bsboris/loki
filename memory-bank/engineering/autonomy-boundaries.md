---
title: Autonomy Boundaries
doc_kind: engineering
doc_function: canonical
purpose: Agent autonomy boundaries: what may run without confirmation, where supervision is required, when to escalate.
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

## Autopilot — no confirmation required

- Edit code within the task scope
- Run local tests and linters
- Create branches and worktrees
- Read logs, metrics, and error tracker
- Create and update internal documentation
- Create and update documentation in memory-bank

## Supervision — proceed, but show at a checkpoint

- Architectural decisions, new services, contract changes — show plan before starting
- Database schema changes and data migrations — show migration before applying
- Deleting code or files — show what and why
- PR to default branch — show diff and test results
- Changes to configuration, routing, or deployment contract — show the diff
- Splitting work into sub-issues — show the breakdown

## Escalation — stop and ask

- Unclear or conflicting business requirements
- Choosing between equally valid approaches with different trade-offs
- Any production action or action against live data
- Sending messages to users or external parties
- Changes to payment, security, auth, or compliance-sensitive integrations
- Conflicting patterns in the codebase — do not guess which is correct
- Task scope creep — do not expand silently

## Escalation rule

If feedback or errors do not shrink after two to three iterations, the issue may be upstream requirements, plan, or environment—not code. Stop the cycle and propose moving back to the previous stage.
