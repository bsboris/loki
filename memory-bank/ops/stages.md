---
title: Stages And Non-Local Environments
doc_kind: engineering
doc_function: canonical
purpose: Placeholder for access to production-like environments. Populate when staging or production exists.
derived_from:
  - ../dna/governance.md
status: draft
audience: humans_and_agents
---

# Stages And Non-Local Environments

Document non-local environments here (production, staging, preview, sandbox, and so on) when they exist.

## Environment inventory

| Environment | Purpose | Access path | Notes |
| --- | --- | --- | --- |

## Common operations

List only real, allowed operations and their canonical entry points. For each operation, record who may run it, approval gates, and read-only vs mutating access boundaries.

## Credentials and access

Record where secrets live, how access is granted, which env vars or secret stores are used, and what counts as bypassing access procedure. Never store real production credentials in the repository.

## Version and health checks

Document safe ways to check deployed version, health endpoint, smoke URL, and basic operational dashboards.

## Logs and observability

Document canonical paths to application logs, metrics, traces, error tracking, and dashboards for primary services.

## Test data and smoke targets

If staging or demo tenants, seed users, or test accounts exist, list them with usage rules.

## Adoption checklist

- [ ] all non-local environments listed
- [ ] canonical access paths recorded
- [ ] safe health/version checks described
- [ ] observability entrypoints listed
- [ ] fake or irrelevant examples removed
