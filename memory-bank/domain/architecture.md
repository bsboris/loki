---
title: Architecture Patterns
doc_kind: domain
doc_function: canonical
purpose: Canonical place for domain data model, module boundaries, integration failure handling, and configuration ownership. Read when changing system behavior, persistence, or Git/GitHub integration.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Architecture patterns

This document describes **Loki’s domain architecture** and how the Rails app is expected to layer responsibilities. Code remains the source of truth for exact class names and APIs; this file captures boundaries and vocabulary shared with product work.

## Data model

These are the **domain aggregates and values** the product revolves around. Names align with [`glossary.md`](glossary.md).

| Concept | Role |
| --- | --- |
| **Repository** | A connected Git project (provider, namespace, name) and defaults such as the host’s default branch used as a starting **base_ref** hint. |
| **Workspace** | A translation session bound to a **repository**, **base_ref**, and **head_ref** (branch or ref); may link to an open PR. Represents “the work on this branch” including diff vs base. |
| **Scope** | A configured slice of the tree: path roots, **source_locale**, and supported **locales**. Comes from repo config, not ad hoc UI. |
| **Entry** | One translatable cell: scope + logical **key_path** + **locale**, with **value** and optional **source_value**, plus flags (**missing**, **outdated**). |
| **Metadata** | Review-oriented fields on an entry or change set (for example reviewed, reviewer, reviewed_at) where the product defines them. |
| **Snapshot** | Flattened key/value state of all in-scope entries at a single **ref** (used for search and full-tree views). |
| **Diff** | Set of changes between **base_ref** and **head_ref** (and metadata needed to drive “changed” views and publish scope). |

**Persistence note (MVP codebase):** the database currently holds **Repository** records only. Workspace, scope, entry, snapshot, and diff behavior is product intent and may live in services, caches, or future tables as the app grows; treat this table as the anchor for everything else.

## Module boundaries

| Layer | Owns | Must not leak |
| --- | --- | --- |
| **Git / host integration** | Talking to the Git host (GitHub today): refs, file content, PR metadata as needed. | Raw HTTP/Octokit details into view code; map to domain errors at the boundary. |
| **Workspace abstraction** | Resolving workspace identity (repo + base + head), loading snapshot/diff views, orchestrating publish. | Ad hoc branch strings scattered through controllers without going through this concept. |
| **YAML / i18n parsing** | Reading and writing locale YAML safely, preserving structure the developer owns. | Business rules about “what a workspace is” (that belongs above this layer). |
| **Web UI** | Forms, Turbo streams, navigation; sends commands to the domain. | Direct Octokit calls or hand-rolled Git protocol. |

Cross-layer rule: **downstream depends on upstream contracts** (UI → workspace → Git/YAML), not on private internals of a sibling module.

## Concurrency and critical sections

When background jobs or concurrent requests touch the same branch, prefer **idempotent** operations keyed by repository + ref, and **short transactions** around local state only. If a queue is introduced, document one owner for retry policy (infrastructure vs application) in [`../engineering/index.md`](../engineering/index.md) and avoid duplicating retries in both places.

## Failure handling (GitHub API)

GitHub access goes through a small client that wraps Octokit and normalizes failures **before** they reach controllers or models that should stay thin.

- **Configuration** — missing token: fail fast with a clear configuration error (not a silent empty state).
- **Not found** — unknown repo or missing resource: surface as a user-visible “not found” outcome.
- **Access denied** (401/403): treat as permission or visibility problem with a single actionable message.
- **Rate limit** — `TooManyRequests`: tell the user to retry later; do not spin tight loops.
- **Network** — timeouts and connection failures: map to a connection error type with retry guidance at the UI layer.
- **Other client errors** — map to a generic “GitHub error” type with safe messaging; log server-side detail for diagnosis.

Controllers and models should **rescue** these mapped types (for example on repository create) and attach **human-readable messages** to the response rather than exposing Octokit exceptions.

## Configuration ownership

- **Canonical schema** for what a repo declares (scopes, glob paths, locales) lives **in the repository** as the agreed config file format (document the filename and keys in code or a short ADR when it stabilizes).
- **Loki** reads that file from the resolved **ref** when building scopes and entry sets; the app does not invent scopes in the database independently of the repo.
- **Rails app config** (credentials, GitHub token, DB) is owned by [`../ops/config.md`](../ops/config.md) when populated; until then, follow `config/` and credentials as in the codebase.

When the environment contract or repo config format changes, update the owner doc and any ADR that records the decision.
