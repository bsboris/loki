---
title: Task Workflows
doc_kind: governance
doc_function: canonical
purpose: Task routing by type and baseline development cycle. Read when receiving a new task to choose an approach.
derived_from:
  - ../dna/governance.md
  - feature-flow.md
canonical_for:
  - task_routing_rules
  - base_development_cycle
  - workflow_type_selection
  - autonomy_gradient
status: active
audience: humans_and_agents
---

# Task Workflows

## Baseline cycle

Every workflow is a chain of repetitions of one cycle:

```text
Artifact → Review → Polish
                  → Decomposition
                  → Accepted
```

An artifact is what is produced at each stage: specification, design doc, plan, code, PR, runbook.

## Human involvement gradient

The closer to business requirements, the more human involvement. The closer to code and local verification, the more the agent works autonomously.

```text
Business requirements  ← human  |  agent →  Code
  PRD, Use Cases         Spec, Plan           PR, Tests
```

## Workflow types

### 1. Small feature

When:

- the task is clear;
- scope is local;
- the solution fits one session or one compact change set.

Flow:

`issue/task -> routing -> implementation -> review -> merge`

### 2. Medium or large feature

When:

- it touches several layers;
- design choices are needed;
- checkpoints and an explicit execution plan are required.

Flow:

`issue/task -> spec -> feature package -> implementation plan -> execution -> review -> handoff`

### 3. Bug fix

Sources may be anything: error tracker, support, QA, direct user report, incident analysis.

Flow:

`report -> reproduction -> analysis -> fix -> regression coverage -> review`

### 4. Refactoring

Split at least into three classes:

- in the course of a delivery task;
- exploratory;
- systemic, with a large change surface.

Exploratory and systemic refactoring usually require an explicit plan and checkpoints.

### 5. Incident / PIR

Flow:

`incident -> timeline -> root cause analysis -> fixes -> prevention work`

Here a human usually confirms RCA and priorities for follow-up work.

## Routing rules

Use the smallest workflow that does not lose control of risk.

- If the task is small and clear, do not inflate it into a large feature package.
- If the task changes contract, rollout, or needs approvals, elevate it to feature flow.
- If feedback does not shrink from iteration to iteration, the problem may be upstream, not in code.
