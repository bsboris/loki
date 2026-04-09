---
title: "Repository Registration Implementation Plan"
spec_link: "memory-bank/features/002/spec.md"
status: active
---

## Overview

Implement the minimum Rails support for storing repositories and rendering a server-side HTML index page at `GET /repositories`, with model and request coverage aligned to the feature spec.

## Plan

1. Add persistence
   - Create `db/migrate/*_create_repositories.rb` for `repositories` with:
     - `provider`
     - `namespace_path`
     - `name`
     - `default_base_ref`
     - timestamps
   - Enforce `null: false` on all repository attributes.
   - Set the database default for `default_base_ref` to `"main"`.
   - Add a unique composite index on `provider`, `namespace_path`, and `name`.
   - Run migrations so `db/schema.rb` is generated or updated with the new table and index.

2. Add the domain model
   - Create `app/models/repository.rb` with `Repository < ApplicationRecord`.
   - Add presence validations for `provider`, `namespace_path`, `name`, and `default_base_ref`.
   - Add a uniqueness validation for `name`, scoped to `provider` and `namespace_path`.
   - Keep `app/models/repository.rb` free of provider-specific behavior, sync logic, and workspace logic.

3. Add the repository index endpoint
   - Update `config/routes.rb` to expose only `GET /repositories`, routed to `RepositoriesController#index`.
   - Create `app/controllers/repositories_controller.rb` with `RepositoriesController#index`.
   - Load repository records from the database in `index`.
   - Create `app/views/repositories/index.html.erb`.
   - Render `No repositories yet` when no records exist.
   - Render each repository’s `provider`, `namespace_path`, `name`, and `default_base_ref` when records exist.
   - Do not add any other repository routes, forms, actions, pagination, filtering, sorting controls, or JavaScript-dependent behavior.

4. Add automated verification
   - Create `spec/models/repository_spec.rb` for:
     - required attributes
     - scoped uniqueness for `provider + namespace_path + name`
     - required `default_base_ref`
     - default `default_base_ref` of `"main"` when omitted on create
   - Create `spec/requests/repositories_spec.rb` for:
     - `GET /repositories` returns `200 OK`
     - response media type is HTML
     - empty state renders `No repositories yet`
     - persisted repository data renders, including `default_base_ref`
     - no extra repository routes are added
   - In `spec/requests/repositories_spec.rb`, make the route constraint explicit by asserting unsupported repository routes are not routable, such as `GET /repositories/new` and `GET /repositories/:id`.

## Expected Files

- `db/migrate/*_create_repositories.rb`
- `db/schema.rb`
- `app/models/repository.rb`
- `app/controllers/repositories_controller.rb`
- `app/views/repositories/index.html.erb`
- `spec/models/repository_spec.rb`
- `spec/requests/repositories_spec.rb`
- `config/routes.rb`

## Verification

- Run targeted specs:
  - `bin/rspec spec/models/repository_spec.rb spec/requests/repositories_spec.rb`
- Run full test suite:
  - `bin/rspec`
- Run lint:
  - `bin/rubocop`
