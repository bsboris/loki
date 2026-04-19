---
title: "ADR-XXX: Short Decision Name"
doc_kind: adr
doc_function: template
purpose: Governed ADR wrapper template. Read to instantiate a decision record without mixing wrapper metadata and the future ADR frontmatter.
derived_from:
  - ../../../dna/governance.md
  - ../../../dna/frontmatter.md
status: active
template_for: adr
template_target_path: ../../../adr/ADR-XXX.md
---

# ADR-XXX: Short Decision Name

This file describes the wrapper template. The instantiated ADR lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

`decision_status: proposed` in the embedded contract below means the ADR text is a proposal and is not treated as an accepted decision until the instantiated ADR is moved to `accepted`.

## Instantiated frontmatter

```yaml
title: "ADR-XXX: Short Decision Name"
doc_kind: adr
doc_function: canonical
purpose: "Records an architectural or engineering decision, its current `decision_status`, and consequences."
derived_from:
  - ../features/FT-XXX/feature.md
status: draft
decision_status: proposed
date: YYYY-MM-DD
must_not_define:
  - current_system_state
  - implementation_plan
```

## Instantiated body

```markdown
# ADR-XXX: Short Decision Name

## Context

Problem, constraint, trade-off, or architectural tension to resolve.

## Decision drivers

- requirements or constraints that affect the choice;
- KPIs, operational, or product factors that matter;
- dependencies and prior decisions to respect.

## Options considered

| Option | Pros | Cons | Why it is / is not the primary candidate |
| --- | --- | --- | --- |
| `Option A` | What it gives | What limits it creates | Rationale |

## Decision

For `decision_status: proposed`, describe the proposed decision here and avoid final-choice language (`chosen`, `definitively rejected`, `accepted`) until the ADR moves to `accepted`. After `accepted`, update wording so this section records the accepted decision, its scope, and touched components.

## Consequences

### Positive

What becomes simpler, better, or possible.

### Negative

What limits, debt, or extra cost appears.

### Neutral / organizational

What documents, processes, or ownership zones must be updated after acceptance.

## Risks and mitigation

Risks that remain after the choice and how they are reduced.

## Follow-up

Downstream documents, tasks, benchmarks, or migrations that should follow this decision.

## Related links

- feature / spec / analysis documents that provide context;
- related ADRs if the decision depends on or refines them.
```
