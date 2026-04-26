# Backlog

Incremental MVP for Loki, aligned with [memory-bank/domain/problem.md](memory-bank/domain/problem.md) (**Open → Explore → Edit → Publish**).

## Conventions

- Each numbered item is a **vertical slice**: shippable user-visible behavior with **automated tests** for the slice’s critical paths.
- Finer tasks belong in PRs or issues, not duplicated here.
- **Order** follows the journey below; defer parallel polish (jobs, extra filters) until the slice that needs it.

## MVP slices

### 1. App shell and connected repository — Done

**Outcome:** Operators use a running app, register a GitHub-backed repository (identity + default branch from the host), list repositories, and get clear errors when GitHub or app configuration fails.

### 2. Workspace (open)

**Outcome:** For a repository, user defines **base_ref** and **head_ref** (pick existing branch or create head from base), persists a **Workspace**, and sees a workspace summary (refs; placeholder or real PR link when publish exists).

*Depends on: GitHub APIs needed for refs/branches beyond default-branch metadata.*

### 3. Explore — config and snapshots

**Outcome:** Loki discovers repo-declared i18n config, loads YAML for configured paths at **both** refs, normalizes into snapshots, and shows understandable errors for bad config or YAML.

### 4. Explore — diff and “Changed”

**Outcome:** Diff base vs head snapshots; entries carry **missing** / **outdated** (and related) signals; **Changed** view with counts.

### 5. Explore — search

**Outcome:** Search and filter over the **head** snapshot (key path, source/translation text, scope, locale, status flags) for full-tree browsing.

### 6. Edit and review

**Outcome:** Edit non-source locale values, write back YAML without destroying unrelated structure, reload snapshot/diff after save; **review metadata** (reviewed / reviewer / time) visible and filterable in Changed and Search.

### 7. Publish

**Outcome:** Commit workspace changes to **head_ref**, push, open or reuse a **PR** to **base_ref**, persist linked PR, prevent obvious duplicate PR mistakes, and show publish result + link; add **audit-friendly** logging (or equivalent) for publish actions.

### 8. Access boundary (MVP gate for multi-user / hosted)

**Outcome:** Only intended users reach repositories and Git-backed operations (exact mechanism TBD: e.g. app login, SSO, or single-tenant deployment rule). Document how GitHub token scope maps to what Loki can do.

---

## Post-MVP / reactive

- Move long-running GitHub work to **background jobs** only if synchronous paths fail UX or timeouts.
- Anything under [non-goals](memory-bank/domain/problem.md#non-goals) stays out unless a separate initiative changes scope.
