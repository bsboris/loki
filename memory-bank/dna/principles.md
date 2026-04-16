---
doc_kind: governance
doc_function: canonical
purpose: Foundational documentation principles for Loki. Root document of the dependency tree.
status: active
---
# Principles

These principles apply to **Loki** (this repository) as-is. They govern how we structure the memory bank, ADRs, and supporting docs so intent stays traceable and duplication stays out.

**Note:** [`PROJECT.md`](../../PROJECT.md) at the repository root remains the high-level product overview until [`memory-bank/domain/problem.md`](../domain/problem.md) is populated. Once `problem.md` is the canonical product summary, `PROJECT.md` is retired in favor of that file.

1. **SSoT.** Every fact has exactly one canonical owner. Duplicates are a defect.
2. **Atomicity.** One file = one topic. If it grows, split it.
3. **Compactness.** A document must stay readable. If it grows, split it.
4. **Progressive disclosure.** Overview first, then links deeper. Top down.
5. **WHY / WHAT / HOW.** `adr/` = why, `feature/` and specs = what, code = how.
6. **Code vs docs.** Code owns implementation. Documentation owns intent, rationale, and contracts.
7. **Index-first.** Every document appears in an index. An orphan file is a defect.
8. **Annotated links.** A link explains what is there and why to read it.
9. Every architectural decision is a separate ADR in the dedicated section.
