---
title: Coding Style
doc_kind: engineering
doc_function: convention
purpose: Loki coding conventions: RuboCop, Rails patterns, locals, POROs, and complexity.
derived_from:
  - ../dna/governance.md
status: active
---

# Coding style

## Linter and formatter

- **RuboCop** with **rubocop-rails-omakase** is the authority for Ruby and Rails style.
- Run **`bin/rubocop`** before handoff; fix new offenses in touched files (do not drive-by “fix the world” unless the task asks for it).

## Rails and structure

- Prefer **standard Rails patterns** over custom frameworks, service layers, or indirection that the codebase does not already use.
- **Keep controllers thin**; push domain rules into models or small **POROs** when logic is not a natural fit for Active Record alone.
- Pass data to views with **`render locals: { ... }`** instead of controller instance variables, unless an existing action already uses another pattern—in that case, match the file until a dedicated refactor.

## Complexity and change discipline

- Prefer **minimal, local changes** that are easy to review over broad refactors.
- **No premature abstractions**: follow existing patterns in the nearest neighbors before introducing new layers or gems.
- For small touch-ups, follow the file’s existing local style unless it conflicts with a canonical rule.
- Do not rewrite unrelated code for consistency alone.
- **New dependencies** need a clear justification; prefer built-in Rails and existing stack pieces.
- Call out risks explicitly for **destructive database changes** or behavior that could break existing workspaces.

## Comments

- Add comments where **why** or non-obvious boundaries matter; skip noise that repeats the code.
