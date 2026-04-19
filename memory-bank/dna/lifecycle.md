---
title: Document lifecycle
doc_kind: governance
doc_function: canonical
purpose: Maintenance rules and sync checklist for governed documents.
derived_from:
  - governance.md
status: active
audience: humans_and_agents
---
# Document lifecycle

Rules that keep governed documentation consistent when things change.

## Maintenance rules

1. **Upstream first.** When you change a fact, find and update the canonical owner first.
2. **Downstream sync.** After upstream changes, check `derived_from` dependents.
3. **Index sync.** When a document is added, removed, or renamed, update the parent `index.md`.
4. **Conflict = defect.** Disagreement inside the authoritative set is fixed immediately.
5. **Conflict = report, not fix.** If an agent finds a mismatch while reading (docs vs docs, or docs vs code it did not change), record it as a finding and tell a human; do not pick winners without human or task ownership of the conflict. **Exception:** when the active task already includes those documents, or when the mismatch is a direct consequence of application or configuration edits in this change, update the governed docs and follow rules 1–3 (upstream, downstream, index).

## Sync checklist

Before committing changes to governed documentation:

- [ ] frontmatter is valid; `derived_from` is set for every governed doc except the authority root `dna/principles.md`; placeholders stay `draft` until populated, then become `active` per `dna/governance.md` (*Scaffold until populated*)
- [ ] canonical `feature` has `delivery_status`; `adr` has `decision_status`
- [ ] parent `index.md` updated when membership or reading order changes
