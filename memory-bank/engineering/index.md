---
title: Engineering Documentation Index
doc_kind: engineering
doc_function: index
purpose: Navigation for Loki engineering rules: style, testing, agent autonomy, and Git workflow.
derived_from:
  - ../dna/governance.md
status: active
---

# Engineering documentation index

These documents govern how the Rails application in this repository is built and reviewed. Stack, bootstrap, and canonical commands live in [`../ops/development.md`](../ops/development.md). Use this index before inventing new conventions in code reviews or agent instructions.

- [`coding-style.md`](coding-style.md)
  RuboCop (rubocop-rails-omakase), Rails conventions, locals vs instance variables, POROs, and how far to abstract.
  Read when: you write or review Ruby/Rails code and need the canonical style and complexity bar.

- [`testing-policy.md`](testing-policy.md)
  RSpec as the test stack, when automation is required, where specs live, and what “done” means for verification.
  Read when: you change behavior, add a bugfix, or need to know which spec type to extend and which commands to run.

- [`autonomy-boundaries.md`](autonomy-boundaries.md)
  What an agent or contributor may do without asking versus checkpoints and hard stops (including GitHub and production).
  Read when: you automate work, delegate to an agent, or need explicit escalation triggers for risky changes.

- [`git-workflow.md`](git-workflow.md)
  Default branch, commit message expectations, and pull request hygiene for this repository.
  Read when: you branch, commit, or open a PR and want the project’s Git conventions in one place.

Architecture decisions are recorded separately under [`../adr/index.md`](../adr/index.md).
