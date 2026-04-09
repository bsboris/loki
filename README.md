# Loki

[![CI](https://github.com/bsboris/loki/actions/workflows/ci.yml/badge.svg)](https://github.com/bsboris/loki/actions/workflows/ci.yml)

Loki is a Git-native translation workspace system for YAML-based i18n files, such as Rails locale files.

It provides a web UI on top of Git branches, where each branch acts as an isolated translation workspace. Users can explore translation diffs, edit entries, review status, and publish changes through the existing Git and pull request workflow.

Git remains the single source of truth. Loki does not introduce an external translation management system.

## Basic Commands

Bootstrap the project:

```bash
bin/setup
```

Run the server:

```bash
bin/rails s
```

Run tests:

```bash
bin/rspec
```

Run database migrations:

```bash
bin/rails db:migrate
```
