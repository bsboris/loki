---
title: "ADR-001: Git as single source of truth"
doc_kind: adr
doc_function: canonical
purpose: Records the founding architectural choice that locale data and workflow authority live in Git and the host platform, not in an external TMS or a parallel database of record.
derived_from:
  - ../domain/problem.md
  - ../domain/architecture.md
status: active
audience: humans_and_agents
decision_status: accepted
date: 2026-04-17
---

# ADR-001: Git as single source of truth

## Context

Loki targets teams that already keep Rails-style YAML locale files in a repository. Translators and PMs need a workspace that hides Git mechanics day-to-day, while developers keep owning file layout and keys. The product must decide **what is authoritative** for translated strings and **how work is isolated and merged**.

Without an explicit decision, implementations tend to drift toward a secondary store (application database or external TMS) as the place “real” translations live, which duplicates Git and complicates merges, audits, and rollback.

## Decision drivers

- **Developer ownership** — Keys, paths, and file structure stay in the repo; translation **values** change in place on branches.
- **Familiar merge story** — Review and promotion follow the host’s pull-request workflow; no parallel merge semantics to invent inside Loki for the MVP.
- **Auditability** — History, blame, and branch isolation are inherited from Git.
- **MVP scope** — Avoid building or integrating a full external TMS; reduce product surface to editing and publishing on top of existing Git hosting (GitHub for the current implementation).

## Options considered

| Option | Pros | Cons | Outcome |
| --- | --- | --- | --- |
| **Git + host as system of record; Loki as editor** | Single copy of truth; PR-based review; matches target users’ repos today | Requires solid Git/GitHub integration; offline and host outages affect the app directly | **Chosen** |
| **External TMS as system of record; Git export/import** | Rich TMS features; translators already in one tool | Second source of truth; sync conflicts; extra vendor and data model; conflicts with “Git-native” positioning | Rejected for MVP |
| **Loki database as system of record; periodic Git sync** | Flexible querying in-app | Diverges from repo; merge and “what shipped” become ambiguous; high operational risk | Rejected |

## Decision

1. **Git (via the connected remote and refs) is the single source of truth** for in-scope locale YAML. Published work is always **commit and push** to the workspace branch; merging to the mainline happens through normal Git and PR practice on the host.
2. **A translation workspace maps to Git state**: a **repository** plus **base_ref** and **head_ref** (see [`../domain/glossary.md`](../domain/glossary.md)). Isolation is **branch-oriented**, not a hidden copy of strings outside Git.
3. **No external TMS** is assumed or required for the MVP. Loki does not treat a third-party TMS as authoritative for locale files.

Application persistence may cache or index content for performance and UX, but those layers are **not** the contract for “what production strings are”; **refs and files in Git are**.

## Consequences

### Positive

- One merge and review path; no duplicate “publish to Git after approving in TMS” unless the team chooses to add that later.
- Translators get a focused UI while developers keep using familiar repo and PR tools.
- Disaster recovery and history are largely “use Git,” not a bespoke export pipeline.

### Negative

- **Host dependency** — Availability, rate limits, and API behavior of GitHub (today) constrain the product; failures must be surfaced clearly (see [`../domain/architecture.md`](../domain/architecture.md)).
- **Conflict handling** — Loki does not provide a dedicated merge/conflict UI; users resolve conflicts in Git on the host ([`../domain/problem.md`](../domain/problem.md)).
- **Search and diff at scale** may require careful engineering (snapshots, indexing) without turning the DB into a second source of truth.

### Neutral / organizational

- Product and engineering docs should **repeat this decision by reference** (link here) instead of re-arguing it in every feature spec.
- If a TMS or secondary store is ever introduced, it should be a **new ADR** that explicitly supersedes or narrows this one.

## Risks and mitigation

| Risk | Mitigation |
| --- | --- |
| Cached state in Loki diverges from Git after manual repo changes | Treat ref fetches and publish responses as reconciliation points; prefer explicit refresh semantics in the UI where needed. |
| Users expect TMS-style workflows (jobs, vendors) | Keep non-goals visible in `domain/problem.md`; any expansion requires product and ADR review. |

## Follow-up

- Repo-level **configuration format** (scopes, paths, locales) remains documented in code and domain architecture until stabilized enough for a dedicated ADR.
- If **workspace persistence** grows (tables for workspaces, drafts), document how those records remain **subordinate** to Git refs in `domain/architecture.md` or a follow-up ADR.

## Related links

- [`../domain/problem.md`](../domain/problem.md) — product summary, workflows, non-goals, constraints.
- [`../domain/architecture.md`](../domain/architecture.md) — data model, Git layer boundaries, failure handling.
- [`../domain/glossary.md`](../domain/glossary.md) — workspace, base_ref, head_ref, snapshot, diff.
