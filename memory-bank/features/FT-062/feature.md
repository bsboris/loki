---
title: "FT-062: daisyUI styling system"
doc_kind: feature
doc_function: canonical
purpose: "Canonical scope and verify for daisyUI on Tailwind, shared partials, and adoption on layout, home, and repositories index."
derived_from:
  - ../../domain/problem.md
  - ../../flows/feature-flow.md
status: active
delivery_status: done
issue_link: "https://github.com/bsboris/loki/issues/62"
must_not_define:
  - implementation_sequence
---

# FT-062: daisyUI styling system

## What

### Problem

Loki lacked a documented, reusable styling system for common UI elements; each screen re-decided styling and consistency suffered.

### Outcome

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | Shared UI primitives | Ad hoc utilities | daisyUI-backed alert + card partials used on key pages | Request + view specs |

### Scope

- `REQ-01` Add daisyUI as Tailwind plugin; keep Propshaft, Importmaps, server-rendered ERB; add `package.json` + lockfile as needed; compile classes into app stylesheet.
- `REQ-02` Configure exactly one default light daisyUI theme applied application-wide from the main layout (`html` root).
- `REQ-03` Shared partials at `app/views/shared/ui/_alert.html.erb` and `_card.html.erb` with locals (`message`, `variant` for alert; `title`, `body` for card), presentation-only, daisyUI class hooks (`alert`, `card`; button class `btn` where spec requires for shared primitives).
- `REQ-04` Update application layout shell, `home#index`, and `repositories#index` to use the styling system; home shows required `h1`/`p` copy and a card; repositories empty state uses alert partial with `info`; each repo row uses card partial; routes unchanged; repository attributes from FT-004 still visible when present.
- `REQ-05` Request specs for affected pages and view specs for partials asserting 200, HTML, content, and class hooks (`card`, `alert`) per the original spec.

### Non-scope

- `NS-01` Dark mode, runtime theme switching, branded custom theme beyond default light, full component library, JS-heavy UI, new product routes or domain behavior, ViewComponent/Phlex/React, bundler for app JS, broad rewrite of not-yet-built screens.

### Constraints / assumptions

- `ASM-01` Tailwind remains primary utilities; daisyUI is a plugin layer.
- `CON-01` No new business logic in partials; minimal footprint beyond listed surfaces.
- `DEC-01` None.

## How

### Solution

Wire daisyUI into the existing Tailwind build, add two shared partials, and adopt them on the current layout and pages with RSpec coverage.

### Change surface

| Surface | Type | Why it changes |
| --- | --- | --- |
| `package.json`, `package-lock.json`, `bin/setup`, `.gitignore` | config | Frontend dependency and bootstrap |
| `app/assets/tailwind/application.css` | config | Plugin + theme |
| `app/views/shared/ui/*` | code | Primitives |
| `app/views/layouts/application.html.erb`, `home/index`, `repositories/index` | code | Adoption |
| `spec/requests/*`, `spec/views/shared/ui/*`, model specs if display helpers added | code | Verify |

### Flow

1. Asset pipeline produces CSS including daisyUI classes used in templates.
2. Layout applies theme; pages compose partials.
3. Tests assert compiled hooks appear in HTML.

### Contracts

| Contract ID | Input / output | Producer / consumer | Notes |
| --- | --- | --- | --- |
| `CTR-01` | Partial locals API | Views / partials | Explicit locals only |
| `CTR-02` | Pages continue prior behavioral contracts from FT-004 | App / users | No new routes |

### Failure modes

- `FM-01` Asset or package misconfiguration — pages may render unstyled; caught by build/setup discipline and specs.

### ADR dependencies

None.

## Verify

### Exit criteria

- `EC-01` daisyUI integrated and theme applied.
- `EC-02` Partials and page adoptions match `REQ-03`–`REQ-04`.
- `EC-03` Automated coverage matches `REQ-05`.

### Traceability matrix

| Requirement ID | Design refs | Acceptance refs | Checks | Evidence IDs |
| --- | --- | --- | --- | --- |
| `REQ-01` | `ASM-01`, `CON-01`, `CTR-02` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-02` | `ASM-01` | `EC-01`, `SC-01` | `CHK-01` | `EVID-01` |
| `REQ-03` | `CTR-01` | `EC-02`, `SC-02` | `CHK-01` | `EVID-01` |
| `REQ-04` | `CTR-01`, `CTR-02` | `EC-02`, `SC-02`, `SC-03` | `CHK-01` | `EVID-01` |
| `REQ-05` | `CON-01` | `EC-03`, `SC-04` | `CHK-01` | `EVID-01` |

### Acceptance scenarios

- `SC-01` Stylesheet build includes daisyUI classes used on adopted pages; theme on layout.
- `SC-02` Home returns 200 HTML with required headings/copy and `card` markup from shared partial.
- `SC-03` Repositories index: empty state uses shared alert with `No repositories yet`; rows use card partial with required fields when data exists.
- `SC-04` View specs prove partial locals render root daisyUI classes (`btn`, `alert`, `card`) as specified.

### Checks

| Check ID | Covers | How to check | Expected result | Evidence path |
| --- | --- | --- | --- | --- |
| `CHK-01` | `EC-01`–`EC-03`, `SC-01`–`SC-04` | `bin/rspec spec/views/shared/ui spec/requests/home_spec.rb spec/requests/repositories_spec.rb` (+ any `repository` model specs per plan) | Green | `EVID-01` |

### Test matrix

| Check ID | Evidence IDs | Evidence path |
| --- | --- | --- |
| `CHK-01` | `EVID-01` | Request and view spec paths under `spec/` |

### Evidence

- `EVID-01` Passing specs covering layout/pages/partials for this slice.

### Evidence contract

| Evidence ID | Artifact | Producer | Path contract | Reused by checks |
| --- | --- | --- | --- | --- |
| `EVID-01` | RSpec output | CI / local | `spec/views/shared/ui/`, `spec/requests/home_spec.rb`, `spec/requests/repositories_spec.rb` | `CHK-01` |
