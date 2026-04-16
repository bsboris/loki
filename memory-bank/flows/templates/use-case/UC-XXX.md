---
title: "UC-XXX: Use Case Name"
doc_kind: use_case
doc_function: template
purpose: Governed use case wrapper template. Read to instantiate a canonical user or operational scenario without mixing wrapper metadata and the future use case frontmatter.
derived_from:
  - ../../../dna/governance.md
  - ../../../dna/frontmatter.md
  - ../../../domain/problem.md
status: active
audience: humans_and_agents
template_for: use_case
template_target_path: ../../../use-cases/UC-XXX-short-name.md
canonical_for:
  - use_case_template
---

# UC-XXX: Use Case Name

This file describes the wrapper template. The instantiated use case lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

A use case records a durable project scenario. It describes trigger, preconditions, main flow, alternatives, and postconditions, but not implementation sequence, architecture, or feature-level verify.

If the scenario is too local and lives only inside one delivery unit, do not promote it to `UC-*`: keep it in `SC-*` on the corresponding feature.

## Instantiated frontmatter

```yaml
title: "UC-XXX: Use Case Name"
doc_kind: use_case
doc_function: canonical
purpose: "Records a durable user or operational scenario for the project."
derived_from:
  - ../domain/problem.md
  # Optional:
  # - ../prd/PRD-XXX-short-name.md
status: draft
audience: humans_and_agents
must_not_define:
  - implementation_sequence
  - architecture_decision
  - feature_level_test_matrix
```

## Instantiated body

```markdown
# UC-XXX: Use Case Name

## Goal

Result the actor should get after successfully completing the scenario.

## Primary actor

Who initiates the scenario.

## Trigger

Event or intent that starts the flow.

## Preconditions

- What must be true before the scenario starts.
- Required data, rights, or system state.

## Main flow

1. First step of the scenario.
2. Second step of the scenario.
3. Observable outcome.

## Alternate flows / exceptions

- `ALT-01` How the scenario branches on an expected alternative.
- `EX-01` Failure or error that must be handled correctly.

## Postconditions

- What is true after successful completion.
- What remains true after unsuccessful completion.

## Business rules

- `BR-01` Rule any implementation of this scenario must obey.
- `BR-02` Constraint or policy that affects the flow.

## Traceability

| Upstream / downstream | References |
| --- | --- |
| PRD | `PRD-XXX` / `none` |
| Features | `FT-XXX`, `FT-YYY` |
| ADR | `ADR-XXX` / `none` |
```
