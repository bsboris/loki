---
title: Release And Deployment
doc_kind: engineering
doc_function: canonical
purpose: Placeholder for release process. Populate when a deployment pipeline exists.
derived_from:
  - ../dna/governance.md
status: active
audience: humans_and_agents
---

# Release And Deployment

## Release flow

Record the real ordered steps for the project when a pipeline exists.

## Release commands

Record canonical project commands and explicit safety rules: required environment variables, environments that need approval, and the boundary between automated and manual release steps.

## Release test plan

For each release, a separate test plan may be useful.

**Format:** `release-v{VERSION}-test-plan.md`

**Minimum structure:**

```markdown
# Release test plan v{VERSION}

**Date:** YYYY-MM-DD
**Previous version:** v{PREV_VERSION}
**Current version:** v{VERSION}
**Environment:** <environment>

## Change overview

| Issue | Title | Type | Priority |
| --- | --- | --- | --- |

## Change verification

- [ ] At least one test case described for each major change set

## Smoke tests

- [ ] Critical user paths verified
- [ ] Health endpoint returns success
```

## Rollback

Record for the real project:

- what counts as a rollback unit;
- fastest safe rollback path;
- who approves production rollback;
- which data or migrations are irreversible.
