---
title: Coding Style
doc_kind: engineering
doc_function: convention
purpose: Coding style template. Populate with real project-specific conventions and tooling.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Coding style

## General rules

- File, module, and directory names follow the primary language’s conventions.
- Add comments only where `why` or boundary conditions are hard to see without them.
- Prefer minimal local complexity over premature abstraction.
- Generated code, vendored code, and migrations follow separate rules if the project defines them.

## Tooling contract

Record the canonical formatting and linting toolchain (formatters, liners, optional pre-commit hooks).

## Language-specific addendum

Add real rules per language or area when adapting (for example backend, frontend, SQL/migrations).

## Change discipline

- Do not rewrite unrelated code for consistency alone unless the task requires it.
- For small touch-ups, follow the file’s existing local style unless it conflicts with a canonical rule.
- If the project is migrating between stacks or styles, record the migration rule explicitly.
