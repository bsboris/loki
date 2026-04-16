---
doc_kind: governance
doc_function: canonical
purpose: Maintenance rules and sync checklist for governed documents.
derived_from:
  - governance.md
status: active
---
# Document lifecycle

Rules that keep governed documentation consistent when things change.

## Maintenance rules

1. **Upstream first.** When you change a fact, find and update the canonical owner first.
2. **Downstream sync.** After upstream changes, check `derived_from` dependents.
3. **Index sync.** When a document is added, removed, or renamed, update the parent `index.md`.
4. **Conflict = defect.** Disagreement inside the authoritative set is fixed immediately.
5. **Conflict = report, not fix.** If an agent finds a mismatch while reading, record it as a finding and tell a human. Do not fix unilaterally unless the current task explicitly requires changing that document.

## Sync checklist

Before committing changes to governed documentation:

- [ ] frontmatter is valid; `derived_from` is set for `active` non-root docs
- [ ] canonical `feature` has `delivery_status`; `adr` has `decision_status`
- [ ] parent `index.md` updated when membership or reading order changes
