# Memory Bank Setup Plan

Project: **Loki** — Git-native translation workspace for YAML-based i18n.
Stage: **Active MVP development.**

---

## Conventions (apply throughout)

- All index files in `memory-bank/` must be named `index.md`, not `README.md`.
- All memory bank files must be written in English.
- The `flows/` folder is kept as-is structurally; its content must be translated to English.
- `AGENTS.md` will contain a single line pointing to the memory bank index.
- All files outside `flows/` and `dna/` must contain only project-specific content. Template examples, dummy placeholder rows, and generic instructional text must be removed — even in deferred files. Deferred files should be clean stubs: real structure, no invented examples.

**Phase order matters:** complete Phase 1 and Phase 2 fully before starting Phase 3. Phase 3 assumes all files are already renamed and in English.

---

## Phase 1 — Rename index files

Rename every `README.md` inside `memory-bank/` to `index.md`, then update all internal cross-references.

- [x] Rename `memory-bank/README.md` → `memory-bank/index.md`
- [x] Rename `memory-bank/dna/README.md` → `memory-bank/dna/index.md`
- [x] Rename `memory-bank/domain/README.md` → `memory-bank/domain/index.md`
- [x] Rename `memory-bank/engineering/README.md` → `memory-bank/engineering/index.md`
- [x] Rename `memory-bank/ops/README.md` → `memory-bank/ops/index.md`
- [x] Rename `memory-bank/ops/runbooks/README.md` → `memory-bank/ops/runbooks/index.md`
- [x] Rename `memory-bank/prd/README.md` → `memory-bank/prd/index.md`
- [x] Rename `memory-bank/features/README.md` → `memory-bank/features/index.md`
- [x] Rename `memory-bank/use-cases/README.md` → `memory-bank/use-cases/index.md`
- [x] Rename `memory-bank/adr/README.md` → `memory-bank/adr/index.md`
- [x] Rename `memory-bank/flows/README.md` → `memory-bank/flows/index.md`
- [x] Rename `memory-bank/flows/templates/README.md` → `memory-bank/flows/templates/index.md`
- [x] Rename `memory-bank/flows/templates/feature/README.md` → `memory-bank/flows/templates/feature/index.md`
- [x] Update all internal links (`README.md` → `index.md`) across every file in `memory-bank/`

---

## Phase 2 — English baseline

Translate all template files to English. No Loki-specific content yet — just mechanical translation of prose, section titles, and comments. Keep all identifiers, frontmatter keys, and structure intact.

### `flows/` (keep structure, translate everything)

- [x] Translate `memory-bank/flows/index.md`
- [x] Translate `memory-bank/flows/workflows.md`
- [x] Translate `memory-bank/flows/feature-flow.md`
- [x] Translate `memory-bank/flows/templates/index.md`
- [x] Translate `memory-bank/flows/templates/feature/index.md`
- [x] Translate `memory-bank/flows/templates/feature/short.md`
- [x] Translate `memory-bank/flows/templates/feature/large.md`
- [x] Translate `memory-bank/flows/templates/feature/implementation-plan.md`
- [x] Translate `memory-bank/flows/templates/prd/PRD-XXX.md`
- [x] Translate `memory-bank/flows/templates/use-case/UC-XXX.md`
- [x] Translate `memory-bank/flows/templates/adr/ADR-XXX.md`

### Deferred files — translate + strip dummy content

For each file: translate to English, remove all template examples and dummy placeholder rows,
leave only real structure. `dna/` files are translated only — dummy content may stay (see convention).

- [x] Translate `memory-bank/dna/index.md`
- [x] Translate `memory-bank/dna/governance.md`
- [x] Translate `memory-bank/dna/frontmatter.md`
- [x] Translate `memory-bank/dna/lifecycle.md`
- [x] Translate `memory-bank/dna/cross-references.md`
- [x] Translate + strip `memory-bank/domain/frontend.md`
- [x] Translate + strip `memory-bank/ops/stages.md`
- [x] Translate + strip `memory-bank/ops/release.md`
- [x] Translate + strip `memory-bank/ops/config.md`
- [x] Translate + strip `memory-bank/ops/runbooks/index.md`
- [x] Translate + strip `memory-bank/prd/index.md`
- [x] Translate + strip `memory-bank/features/index.md`
- [x] Translate + strip `memory-bank/use-cases/index.md`

---

## Phase 3 — Populate with Loki-specific content

Replace template placeholders with real project content. All files are already in English after Phase 2.

### 3.1 Root index

- [ ] Rewrite `memory-bank/index.md` as the single navigation entry point for humans and agents.
  List all active sections with one-line purpose annotations. Clearly mark deferred sections.

### 3.2 DNA

- [ ] Populate `memory-bank/dna/principles.md`. Keep the 9 principles as-is; they apply to Loki directly.
  Add one note: `PROJECT.md` is retired once `domain/problem.md` is populated.

### 3.3 Domain

- [ ] Populate `memory-bank/domain/problem.md`. Migrate and adapt content from `PROJECT.md`:
  product summary, users (Translator/PM + Developer), MVP goal, core workflows
  (open → explore → edit → publish), non-goals, constraints (Git as SSoT, no external TMS).
- [ ] Populate `memory-bank/domain/architecture.md`. Include:
  - data model: Repository, Workspace, Scope, Entry, Metadata, Snapshot, Diff
  - module boundaries: Git layer, workspace abstraction, YAML parsing, GitHub integration
  - failure handling for GitHub API calls
  - configuration ownership (repo config file: scopes, paths, locales)
- [ ] Create `memory-bank/domain/glossary.md` (new file, not in template). Define canonical domain
  terms: *Workspace*, *Scope*, *Entry*, *Snapshot*, *Diff*, *Missing*, *Outdated*, *base_ref*, *head_ref*.
  This is Loki-specific vocabulary that appears constantly and needs a single authoritative source.
- [ ] Populate `memory-bank/domain/index.md` in English: list `problem.md`, `architecture.md`,
  `glossary.md` as active; note `frontend.md` as deferred.

### 3.4 Engineering

- [ ] Populate `memory-bank/engineering/index.md` in English: list all 4 active files.
- [ ] Populate `memory-bank/engineering/coding-style.md`:
  - linter: `rubocop` (rubocop-rails-omakase), `bin/rubocop`
  - prefer `render locals:` over controller instance variables
  - use POROs for domain logic
  - keep controllers thin
  - no premature abstractions; prefer minimal local complexity
  - follow existing local patterns before changing style
- [ ] Populate `memory-bank/engineering/testing-policy.md`:
  - framework: RSpec (`bin/rspec`)
  - required: automated coverage for any behavioral change
  - done criteria: all tests pass + lint passes
  - project-specific: where to add specs, canonical RSpec patterns for the project
- [ ] Populate `memory-bank/engineering/autonomy-boundaries.md`. Adapt existing template sections
  to Loki-specific context:
  - autopilot: editing code, running tests/lint, creating branches, updating memory bank
  - supervision: DB migrations, schema changes, PR to main, architectural changes
  - escalation: unclear requirements, GitHub API/auth changes, any production actions
- [ ] Populate `memory-bank/engineering/git-workflow.md`:
  - default branch: `main`
  - commit style: present-tense, concise
  - PR: green local checks required before opening; short title; body covers what/how/risks

### 3.5 Operations

- [ ] Populate `memory-bank/ops/index.md` in English: list `development.md` as active;
  note `stages.md`, `release.md`, `config.md`, `runbooks/` as deferred.
- [ ] Populate `memory-bank/ops/development.md`:
  - setup: `bin/setup`
  - server: `bin/rails s`
  - tests: `bin/rspec`
  - lint: `bin/rubocop`
  - stack: Rails 8.1, PostgreSQL, RSpec, Hotwire, Importmaps, Tailwind
  - note: prefix `bundle exec` commands with `unset CI && direnv exec <path>` when behavior
    changes in CI environments

### 3.6 ADR

- [ ] Populate `memory-bank/adr/index.md` in English: keep as an empty registry with naming rules.
- [ ] Create `memory-bank/adr/ADR-001-git-as-single-source-of-truth.md`. Document the founding
  architectural decision: Git branch = workspace, no external TMS, rationale, consequences.

---

## Phase 4 — Update AGENTS.md

- [ ] Replace the entire content of `AGENTS.md` with:
  ```
  See [memory-bank/index.md](memory-bank/index.md).
  ```

---

## Phase 5 — Retire PROJECT.md

- [ ] Add a deprecation notice at the top of `PROJECT.md` pointing to `memory-bank/domain/problem.md`
  as the canonical source. Do not delete — it may be referenced externally.

---

## Deferred sections

Leave translated placeholder files in place. Do not populate until the trigger condition is met.

| Section | Activate when |
|---|---|
| `prd/` | Planning a V2 initiative that spans multiple feature packages |
| `use-cases/` | Core flows (open/edit/publish) are stable enough to canonicalize |
| `features/` | Tracking a parallel backlog beyond a single focused sprint |
| `ops/stages.md` | Staging or production environment exists |
| `ops/release.md` | Deployment pipeline is in place |
| `ops/config.md` | Env vars grow beyond a handful |
| `ops/runbooks/` | Post-launch, first operational incident |
| `domain/frontend.md` | Hotwire/Turbo/Stimulus layer needs explicit conventions |
| `dna/governance.md` + `frontmatter.md` + `lifecycle.md` + `cross-references.md` | Docs multiply and meta-governance overhead becomes worthwhile |
