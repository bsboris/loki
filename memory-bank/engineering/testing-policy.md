---
title: Testing Policy
doc_kind: engineering
doc_function: canonical
purpose: Loki testing expectations: RSpec, required automation, spec placement, and done criteria.
derived_from:
  - ../dna/governance.md
  - ../flows/feature-flow.md
status: active
audience: humans_and_agents
---

# Testing policy

## Stack and commands

- **Framework:** RSpec with **rspec-rails** (`spec/rails_helper.rb`, `spec/spec_helper.rb`).
- **Run the suite:** `bin/rspec`.
- **External HTTP in tests:** WebMock is enabled in `rails_helper`; stub outbound calls (see `spec/support/github_client_helpers.rb` for GitHub client helpers).

## Required automation

- Any **behavior change** that can be asserted deterministically must include or update **automated examples** (request, model, or view spec as appropriate).
- **Bugfixes** should add a regression example for the failing scenario when it is practical to reproduce in specs.
- **New or changed contracts** (routes, public model APIs, integration boundaries) should have coverage at the lowest layer that gives a stable signal—usually request or model specs.

## Done criteria

- **`bin/rspec`** passes for the relevant scope (targeted files first for small edits, full suite when behavior is wide-ranging).
- **`bin/rubocop`** passes.
- The handoff should state **what changed** and **which checks were run** (see project agent guidelines).

## Where to add specs

| Change | Primary location |
|--------|-------------------|
| HTTP routes, controllers, HTML/Turbo responses | `spec/requests/**/*_spec.rb` (`type: :request`) |
| Active Record models, validations, domain logic | `spec/models/**/*_spec.rb` (`type: :model`) |
| View components or partials tested in isolation | `spec/views/**/*_spec.rb` |
| Cross-cutting helpers | `spec/support/**/*.rb` (not `*_spec.rb`) |

Generators place new specs next to the code they exercise; **keep that layout** unless a task explicitly reorganizes tests.

## Canonical RSpec patterns for Loki

- Use **`require "rails_helper"`** at the top of files that need Rails (models, requests, views).
- **Request specs** use integration-style examples: `get`/`post`/`patch`/`delete`, then `expect(response)` and, when needed, **`Nokogiri::HTML5`** for HTML assertions (see existing request specs).
- **Model specs** exercise persistence and domain behavior; include **`GithubClientHelpers`** when stubbing GitHub access (`type: :model` or `:request` per `rails_helper`).
- Prefer **explicit setup** in each example or small `let` blocks; avoid deep shared context unless it already exists for that area.
- **Fixtures** live under `spec/fixtures` when used; transactional examples remain the default (`use_transactional_fixtures`).

## Doc-driven features

When a change is driven by the full feature flow in [`../flows/feature-flow.md`](../flows/feature-flow.md), keep the **test inventory and strategy** aligned with that flow’s gates. For day-to-day fixes and small tasks, the rules above are sufficient.

## Manual-only gaps

- Manual checks are acceptable for **one-off UX polish** or **third-party behavior** that cannot be stubbed reliably—call them out in the PR with steps taken.
- They **do not replace** automated coverage where a deterministic spec is realistic.
