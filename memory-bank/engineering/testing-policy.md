---
title: Testing Policy
doc_kind: engineering
doc_function: canonical
purpose: Repository testing policy: test case design obligations, automated regression requirements, and allowed manual-only gaps.
derived_from:
  - ../dna/governance.md
  - ../flows/feature-flow.md
status: active
canonical_for:
  - repository_testing_policy
  - feature_test_case_inventory_rules
  - automated_test_requirements
  - sufficient_test_coverage_definition
  - manual_only_verification_exceptions
  - simplify_review_discipline
  - verification_context_separation
must_not_define:
  - feature_acceptance_criteria
  - feature_scope
audience: humans_and_agents
---

# Testing policy

## Project adaptation

Populate project-specific testing stack:

- primary test framework;
- test data strategy;
- canonical local commands;
- required CI jobs;
- allowed manual-only exceptions.

## Core rules

- Any behavior change that can be checked deterministically must get automated regression coverage.
- Any new or changed contract must get contract-level automated verification.
- Any bugfix must add a regression test for the reproducible scenario.
- Required automated tests only close risk when they pass locally and in CI.
- Manual-only verify is only allowed as an explicit exception and does not replace automated coverage where automation is realistic.

## Ownership split

- Canonical test cases for a delivery unit live in `feature.md` via `SC-*`, feature-specific `NEG-*`, `CHK-*`, and `EVID-*`.
- `implementation-plan.md` only owns execution strategy: which test surfaces to add or update, which gaps stay temporarily manual-only and why.

## Feature flow expectations

Canonical lifecycle gates live in [../flows/feature-flow.md](../flows/feature-flow.md):

- by **Design ready**, `feature.md` already records the test case inventory;
- by **Plan ready**, `implementation-plan.md` includes `Test strategy` with planned automated coverage and manual-only gaps;
- by **Done**, required tests are added, local commands are green, and CI does not contradict local verify.

## What counts as sufficient coverage

- Main changed behavior and the nearest regression path are covered.
- New or changed contracts, events, schema, or integration boundaries are covered.
- Critical failure modes from `FM-*`, bug history, or acceptance risks are covered.
- Feature-specific negative/edge scenarios are covered when they change the verdict.
- Line coverage percentage alone is insufficient; scenario- and contract-level coverage matter.

## When manual-only is allowed

- The scenario depends on live infra, external systems, hardware, a non-deterministic environment, or human UI judgment.
- For each manual-only gap: reason, manual procedure, follow-up owner.
- If a manual-only gap leaves a critical path without regression protection, the feature is not done.

## Simplify review

A separate verification pass after functional testing. Goal: confirm the implementation is minimally complex.

- Runs after tests pass and before the closure gate.
- Watch for: premature abstraction, deep nesting, duplicated logic, dead code, overengineering.
- Three similar lines beat premature abstraction. Abstraction is justified only when it clearly reduces risk or repetition.

## Verification context separation

Treat verification stages as separate passes:

1. **Functional verification** — tests pass; acceptance scenarios covered
2. **Simplify review** — code is minimally complex
3. **Acceptance test** — end-to-end against `SC-*`

Small features may combine passes in one session; simplify review is not skipped.

## Project-specific conventions

Record when populated:

- where to add new tests;
- canonical helper/setup pattern;
- how to work with the database, mocks, and fixtures;
- commands the agent must run before handoff.

## Checklist for template adoption

- [ ] real local test commands recorded
- [ ] required CI suites listed
- [ ] deterministic test data pattern documented
- [ ] manual-only exceptions described
- [ ] policy does not contradict [../flows/feature-flow.md](../flows/feature-flow.md)
