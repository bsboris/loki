---
title: Architecture Patterns
doc_kind: domain
doc_function: canonical
purpose: Canonical place for architectural boundaries. Read when changes touch modules, background processes, integrations, or configuration.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Architecture patterns

This document defines expected architectural rules for the project, not a specific implementation. Record real bounded contexts, integration boundaries, and technical constraints when populated.

## Module boundaries

| Context | Owns | Must not depend on directly |
| --- | --- | --- |

Minimum rules when documenting:

- a module owns its state and public contracts;
- cross-module dependencies go through an explicitly named API, event, or adapter;
- UI, jobs, and integrations must not read other modules’ internals without going through the owner.

## Concurrency and critical sections

If the project has concurrent work, record the canonical pattern for critical sections and background processing:

- allowed locking pattern;
- forbidden patterns and why;
- what counts as idempotent recovery;
- transaction boundaries relative to external APIs.

If the project uses a job queue, add canonical rules for concurrency control.

## Failure handling and error tracking

Record a single approach for:

- where errors propagate vs map to a domain verdict;
- how contextual metadata is added for an error tracker;
- where retry policy is owned by infrastructure and must not be duplicated with local `rescue`.

## Configuration ownership

Document the configuration ownership model, not every environment variable:

- where the canonical configuration schema lives;
- which files or classes own the layer;
- where defaults are set;
- who maintains the env contract.

When configuration changes, update schema owner, defaults or overlays, and [`../ops/config.md`](../ops/config.md).
