See PROJECT.md for project description.

## Stack
Ruby on Rails 8.1, PostgreSQL, RSpec. Hotwire + Importmaps + Tailwind for frontend.

## Key commands
- `bin/setup` — bootstrap
- `bin/rails s` — run server
- `bin/rspec` — run tests
- `bin/rubocop` — run Rubocop

## Conventions
- Prefer standard Rails conventions over custom abstractions
- Keep changes minimal, local, and easy to review
- Do not introduce new dependencies unless clearly justified.
- Prefer built-in Rails features before adding service objects or custom frameworks
- Keep controllers thin, business logic in models/domain objects when appropriate
- Avoid premature optimization and broad refactors
- Preserve backwards compatibility unless the task explicitly requires breaking changes
- For destructive database changes, call out risks explicitly

## Code guidelines
- Follow Rubocop (rubocop-rails-omakase)
- Prefer passing data to Rails views via `render locals: { ... }` instead of controller instance variables
- Use POROs for domain logic

## Workflow
- Before changing code, inspect the relevant files and follow existing patterns
- For non-trivial work, briefly state the plan before editing
- After editing, summarize changed files and verification results
- Do not rename or move files unless required
- Do not introduce new dependencies unless clearly justified
- If a change is scoped, prefer targeted checks first, then run the full relevant suite

## Done
A task is done when:
- the requested change is implemented
- all tests pass
- lint passes
- the final note includes what changed and which checks were run
