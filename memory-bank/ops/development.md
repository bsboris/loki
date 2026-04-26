---
title: Development Environment
doc_kind: ops
doc_function: canonical
purpose: Loki local development: bootstrap, stack, canonical commands, and common pitfalls for humans and agents.
derived_from:
  - ../dna/governance.md
status: active
---

# Development environment

**Loki** is a Ruby on Rails application. Use the commands below from the repository root unless a script says otherwise.

## Stack

- **Ruby on Rails** 8.1.x
- **PostgreSQL** (Active Record)
- **RSpec** for automated tests
- **Hotwire** (Turbo + Stimulus), **Importmaps**, **Tailwind CSS** (via `tailwindcss-rails`) for the frontend

## Setup

Run:

```sh
bin/setup
```

This installs Ruby gems (`bundle install` as needed), runs `npm install` (with a cache path defined in the script), prepares the database (`bin/rails db:prepare`), clears logs and temp files, and by default **starts** `bin/dev` (Foreman). Use `bin/setup --skip-server` when you only want dependencies and the database prepared.

Pass `bin/setup --reset` if you need `bin/rails db:reset` after prepare (destructive to local data).

**Prerequisites:** Ruby and Bundler compatible with the repo, Node/npm for the setup script, and a running PostgreSQL instance reachable from `config/database.yml`.

## Daily commands

| Task | Command |
| --- | --- |
| Bootstrap / update deps and DB | `bin/setup` (optional `--skip-server`, `--reset`) |
| App + Tailwind watcher (typical dev) | `bin/dev` (Rails server + `tailwindcss:watch` via `Procfile.dev`) |
| Rails server only | `bin/rails s` (default port **3000** unless `PORT` is set) |
| Tests | `bin/rspec` |
| Lint | `bin/rubocop` |

Run targeted specs or a single file as usual through RSpec, for example `bin/rspec spec/models/foo_spec.rb`.

## `bundle exec` and `CI`

Some tools behave differently when the `CI` environment variable is set (skips, stricter defaults, or different load paths). If you run `bundle exec …` and need the same behavior as an interactive direnv-loaded shell, prefix the command:

```sh
unset CI && direnv exec <path-to-repository-root> bundle exec <command>
```

Replace `<path-to-repository-root>` with the absolute path to **this** Git checkout (the Loki repository), not another project’s tree. If shell tooling, direnv, or per-user rules mention a different repo path, override them here so `bundle exec` runs against Loki’s `Gemfile` and environment.

## Browser and local URL

With the default Foreman/Rails setup, the web app listens on **http://localhost:3000** unless you override `PORT`.

## Database

Routine schema work uses standard Rails tasks (`bin/rails db:migrate`, `db:rollback`, and so on). Fresh clones rely on `bin/setup` / `db:prepare`; use `db:reset` only when you intend to drop and recreate local data.
