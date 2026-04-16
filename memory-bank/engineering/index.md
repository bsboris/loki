---
title: Engineering Documentation Index
doc_kind: engineering
doc_function: index
purpose: Navigation for engineering-level template documentation.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Engineering documentation index

The `memory-bank/engineering/` directory holds engineering rules that are usually adapted per repository after copying the template.

- [Testing policy](testing-policy.md) — testing rules, required automated tests, sufficient coverage. Answers: when a feature must have test cases and when manual-only verify is allowed.
- [Autonomy boundaries](autonomy-boundaries.md) — agent autonomy: autopilot, supervision, escalation. Answers: what the agent may do alone and where it must stop and ask.
- [Coding style](coding-style.md) — code conventions, tooling, and local complexity rules.
- [Git workflow](git-workflow.md) — git conventions: commits, branches, PRs, and optional worktrees.
- [ADR](../adr/index.md) — instantiated Architecture Decision Records for the project.
