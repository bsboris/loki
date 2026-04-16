---
title: "daisyUI Styling System Spec"
brief_link: "memory-bank/features/003/brief.md"
issue_link: "https://github.com/bsboris/loki/issues/62"
status: active
---

## Goal

Define the minimum implementation needed to establish daisyUI as Loki's shared UI styling system on top of Tailwind, so common interface elements can be rendered with a documented, reusable styling vocabulary across existing and upcoming Rails views.

## Scope

Included in this feature:
- Add daisyUI as a Tailwind plugin in the existing Rails frontend stack.
- Keep the application server-rendered with Rails views, Tailwind, Propshaft, and Importmaps.
- Add the frontend build/configuration needed for daisyUI classes to compile into the app stylesheet.
- Configure one default light theme for the application.
- Introduce reusable shared view partials for a small set of base UI primitives:
  - alert
  - card
- Apply the shared styling system to existing shared layout surfaces and current pages that already exist in the app:
  - application layout shell
  - home page
  - repositories index page
- Add automated verification covering successful rendering of the updated pages and the presence of the shared partials.

Not included in this feature:
- Dark mode or runtime theme switching.
- A custom branded theme beyond selecting/configuring one default light daisyUI theme.
- A full component library for every possible UI element.
- JavaScript UI behaviors beyond what daisyUI styles provide through HTML/CSS.
- New product flows, new routes, or new domain behavior.
- ViewComponent, Phlex, or any new component framework.
- A broad rewrite of all views beyond the existing layout and current pages.

Affected modules:
- Frontend styling system configuration
- Shared UI partials
- Adopted server-rendered pages and their verification

## Invariants

- Tailwind remains the underlying utility framework; daisyUI is added as a plugin layer on top of it.
- The application remains server-rendered with standard Rails ERB views.
- Importmaps remain the JavaScript approach; this feature does not introduce a JavaScript bundler for application code.
- The styling system uses one default light theme only.
- Shared styling primitives are implemented with Rails partials, not a new component framework.
- The feature does not add new business logic, persistence, routes, or API endpoints.

## Requirements

1. Frontend integration
   - Add frontend package/configuration so Tailwind loads the `daisyui` plugin.
   - Add a `package.json` file and a lockfile for the frontend packages required to load `daisyui`.
   - Configure Tailwind so daisyUI classes used in Rails templates and shared partials are included in the generated stylesheet.
   - The existing Rails asset flow must continue to serve the compiled stylesheet through the application layout.
   - The feature must not replace Tailwind, Propshaft, or Importmaps.

2. Theme configuration
   - Configure exactly one default light daisyUI theme.
   - The theme must apply application-wide through the main layout.
   - No user-facing theme toggle or dark theme behavior is required.

3. Shared styling primitives
   - Add shared ERB partials for these primitives:
     - alert
     - card
   - The partials must be implemented at these paths:
     - `app/views/shared/ui/_alert.html.erb`
     - `app/views/shared/ui/_card.html.erb`
   - These partials must encapsulate the default daisyUI class vocabulary for each primitive.
   - The partial API must use Rails locals rather than instance variables.
   - The partial locals must be explicit and limited to current usage:
     - alert: `message:`, `variant:`
     - card: `title:`, `body:`
   - `variant:` is only required to support `primary` for button and `info` for alert in this feature.
   - The partials must remain presentation-only and must not contain domain logic.

4. Layout and page adoption
   - Update the main application layout to use the shared styling system for the primary page shell.
   - The main layout must apply the selected daisyUI theme on the root `html` element.
   - Update the current home page so it renders:
     - one `h1` with the text `Loki`
     - one paragraph with the text `Git-native translation workspace system for YAML-based i18n.`
     - one card rendered through the shared card partial with title `Styling system` and body `daisyUI primitives are available for shared UI elements.`
   - Update the repositories index page to use the shared styling system for:
     - page container/surface
     - headings
     - empty state
     - repository item presentation
   - The repositories empty state must render `No repositories yet` through the shared alert partial with alert variant `info`.
   - Each repository item must render through the shared card partial.
   - Existing page behavior and route structure must remain unchanged.
   - The repository index must continue to render all repository attributes already required by feature 002.

5. Documentation in code
   - Any helper stylesheet or config file added for daisyUI integration must be specific to this styling system only.
   - This feature does not require additional prose documentation outside the codebase memory-bank spec itself.

6. Automated verification
   - Add request specs for the existing pages affected by this feature.
   - The automated checks must verify:
     - updated pages still return `200 OK`
     - updated pages still return HTML content
     - the home page includes `Loki`
     - the home page renders markup produced by the shared card partial
     - the repositories index still renders the empty state text when there are no repositories
     - the repositories index still renders persisted repository data
     - the repositories empty state renders markup produced by the shared alert partial
     - each repository item renders markup produced by the shared card partial
     - the rendered HTML for adopted pages includes these daisyUI class hooks:
       - home page card uses class `card`
       - repositories empty state uses class `alert`
       - repository items use class `card`
   - Add view specs for the shared partials that verify the required locals render the corresponding daisyUI root classes:
     - button renders class `btn`
     - alert renders class `alert`
     - card renders class `card`
   - The test suite must run under the existing Rails/RSpec setup without introducing a new test framework dependency.

## States

- Loading: not applicable. This feature is server-rendered and defines no client-side loading UI.
- Success:
  - the home page returns `200 OK` and renders the required heading, paragraph, and shared card markup
  - the repositories index returns `200 OK` and renders either the empty state alert or repository cards
- Empty:
  - when there are zero repositories, the repositories index renders the text `No repositories yet` inside markup from the shared alert partial
- Error handling:
  - no custom application-level error UI is added in this feature
  - unhandled controller/view exceptions remain default Rails behavior and are out of scope
  - frontend package installation or asset build failures are not a user-facing state and are out of scope for acceptance

## Acceptance Criteria

1. daisyUI is integrated into the existing Tailwind-based frontend setup and its classes compile into the application stylesheet used by Rails views.
2. The application uses exactly one default light daisyUI theme applied through the main layout.
3. Shared partials exist at:
   - `app/views/shared/ui/_alert.html.erb`
   - `app/views/shared/ui/_card.html.erb`
6. The alert partial accepts `message:` and `variant:` locals and renders class `alert`.
7. The card partial accepts `title:` and `body:` locals and renders class `card`.
8. The application layout is updated to use the styling system for the main page shell and applies the selected daisyUI theme at the layout level.
9. The home page returns `200 OK`, returns HTML, includes one `h1` with text `Loki`, includes one paragraph with text `Git-native translation workspace system for YAML-based i18n.`, and renders one shared card with class `card`.
10. `GET /repositories` still returns `200 OK` and an HTML response.
11. When there are zero repositories, the repositories index includes `No repositories yet` and renders the empty state through the shared alert partial with class `alert`.
12. When repositories exist, the repositories index displays `provider`, `namespace_path`, `name`, and `default_base_ref`, and each repository item renders through the shared card partial with class `card`.
13. The implementation adds no new product routes, no new domain workflows, no theme toggle, and no new frontend framework beyond the minimal package/configuration required to load daisyUI.
13. The implementation adds no new product routes, no new domain workflows, no theme toggle, and no new frontend framework beyond `daisyui` and the frontend package files required to load it.

## Implementation Constraints

- Use standard Rails conventions for assets, views, partials, and RSpec coverage.
- Keep changes minimal, local, and easy to review.
- Prefer configuration and partials over custom abstraction layers.
- Do not introduce ViewComponent, Phlex, React, or any other new rendering framework.
- Do not migrate application JavaScript away from Importmaps.
- Do not add dark mode, multiple themes, or runtime theme switching in this feature.
- Do not restyle unrelated future screens that do not yet exist.
- Do not remove Tailwind utility usage entirely; direct utility classes may still be used in views where shared primitives do not fit.
- Do not introduce new business/domain logic while applying the styling system.
