---
title: "PRD-XXX: Product Initiative Name"
doc_kind: prd
doc_function: template
purpose: Governed PRD wrapper template. Read to instantiate a compact Product Requirements Document without mixing wrapper metadata and the future PRD frontmatter.
derived_from:
  - ../../../dna/governance.md
  - ../../../dna/frontmatter.md
  - ../../../domain/problem.md
status: active
audience: humans_and_agents
template_for: prd
template_target_path: ../../../prd/PRD-XXX-short-name.md
canonical_for:
  - prd_template
---

# PRD-XXX: Product Initiative Name

This file describes the wrapper template. The instantiated PRD lives below as an embedded contract and is copied without wrapper frontmatter and history.

## Wrapper notes

The PRD in this template is intentionally lean. It records product problem, users, goals, scope, and success metrics, but does not own implementation sequencing, architecture decisions, or verify/evidence contracts in downstream feature packages.

The PRD builds on `domain/problem.md` and does not replace it. Do not copy the entire project-wide context if it is already described upstream.

Use a PRD as an upstream layer between general project context and several feature packages. If the initiative is local and does not need a separate product-layer document, you may omit a PRD.

## Instantiated frontmatter

```yaml
title: "PRD-XXX: Product Initiative Name"
doc_kind: prd
doc_function: canonical
purpose: "Records product problem, target users, goals, scope, and success metrics for the initiative."
derived_from:
  - ../domain/problem.md
status: draft
audience: humans_and_agents
must_not_define:
  - implementation_sequence
  - architecture_decision
  - feature_level_verify_contract
```

## Instantiated body

```markdown
# PRD-XXX: Product Initiative Name

## Problem

User or business problem the initiative solves. Use problem language, not solution language. Reference general context from `../domain/problem.md` and record only this initiative's delta.

## Users and jobs

Who the primary user is and what job they are trying to do.

| User / segment | Job to be done | Current pain |
| --- | --- | --- |
| `primary-user` | What they want to achieve | What blocks them today |

## Goals

- `G-01` Required product outcome.
- `G-02` Optional additional outcome.

## Non-goals

- `NG-01` What is explicitly out of initiative scope.
- `NG-02` What must not be silently assumed at implementation level.

## Product scope

Describe scope at capability level, not as a change set.

### In scope

- What must become possible for the user or system.

### Out of scope

- What stays outside the initiative.

## UX / business rules

- `BR-01` Important product or operations rule.
- `BR-02` Constraint every downstream feature must respect.

## Success metrics

| Metric ID | Metric | Baseline | Target | Measurement method |
| --- | --- | --- | --- | --- |
| `MET-01` | What we measure | Starting point | What counts as success | How we verify |

## Risks and open questions

- `RISK-01` What could derail the initiative at product level.
- `OQ-01` What is still unknown.

## Downstream features

List expected feature packages if already known.

| Feature | Why it exists | Status |
| --- | --- | --- |
| `FT-XXX` | Which slice it implements | planned / draft / active |
```
