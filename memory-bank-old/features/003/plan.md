---
title: "daisyUI Styling System Implementation Plan"
spec_link: "memory-bank/features/003/spec.md"
status: active
---

## Overview

Implement the minimum frontend setup and shared ERB primitives needed to establish daisyUI as Loki's default styling system for the existing layout, home page, and repositories index.

## Plan

1. Add frontend styling dependencies
   - Add `package.json` and `package-lock.json` with the `daisyui` dependency.
   - Update `bin/setup` to install frontend packages during local bootstrap.
   - Ignore `node_modules/` in `.gitignore`.
   - Extend `app/assets/tailwind/application.css` to load daisyUI and define a single default light theme.

2. Add reusable shared UI partials
   - Create `app/views/shared/ui/_alert.html.erb` with `message:` and `variant:` locals and root class `alert`.
   - Create `app/views/shared/ui/_card.html.erb` with `title:` and block body content and root class `card`.
   - Keep the implementation as standard Rails partials without introducing a component framework.

3. Apply the styling system to existing screens
   - Update `app/views/layouts/application.html.erb` to apply the global daisyUI theme and shared page shell styling.
   - Update `app/views/home/index.html.erb` to render the required heading, copy, and a shared card.
   - Update `app/views/repositories/index.html.erb` to render the empty state through the alert partial and repository entries through the card partial.
   - Add a small presenter-style helper method on `Repository` for the card title without changing domain workflows.

4. Add verification
   - Extend request specs for the home page and repositories index to assert the required content and shared primitive markup.
   - Add view specs for the shared alert and card partials.
   - Add model coverage for the repository display helper.

## Expected Files

- `package.json`
- `package-lock.json`
- `.gitignore`
- `bin/setup`
- `app/assets/tailwind/application.css`
- `app/views/shared/ui/_alert.html.erb`
- `app/views/shared/ui/_card.html.erb`
- `app/views/layouts/application.html.erb`
- `app/views/home/index.html.erb`
- `app/views/repositories/index.html.erb`
- `app/models/repository.rb`
- `spec/views/shared/ui/alert_spec.rb`
- `spec/views/shared/ui/card_spec.rb`
- `spec/requests/home_spec.rb`
- `spec/requests/repositories_spec.rb`
- `spec/models/repository_spec.rb`

## Verification

- Run targeted specs:
  - `bin/rspec spec/views/shared/ui spec/requests/home_spec.rb spec/requests/repositories_spec.rb spec/models/repository_spec.rb`
- Run full test suite:
  - `bin/rspec`
- Run lint:
  - `bundle exec rubocop --cache false`
