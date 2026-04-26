---
title: Principles
doc_kind: governance
doc_function: canonical
purpose: Foundational documentation principles for Loki. Root document of the dependency tree.
status: active
---
# Principles

These principles apply to **Loki** (this repository) as-is. They govern how we structure the memory bank, ADRs, and supporting docs so intent stays traceable and duplication stays out.

**Note:** The canonical product summary is [`memory-bank/domain/problem.md`](../domain/problem.md).

1. **SSoT.** Every fact has exactly one canonical owner. Duplicates are a defect.
2. **Atomicity.** One file = one topic. If it grows, split it.
3. **Compactness.** A document must stay readable. If it grows, split it.
4. **Progressive disclosure.** Overview first, then links deeper. Top down.
5. **WHY / WHAT / HOW.** `memory-bank/adr/` = why; `memory-bank/features/`, `memory-bank/prd/`, and `memory-bank/use-cases/` = what; code = how.
6. **Code vs docs.** Code owns implementation. Documentation owns intent, rationale, and contracts.
7. **Index-first.** Every document appears in an index. An orphan file is a defect.
8. **Annotated links.** A link explains what is there and why to read it.
9. Every architectural decision is a separate ADR in the dedicated section.
