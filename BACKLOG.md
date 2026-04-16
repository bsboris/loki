# Backlog

MVP feature backlog for Loki, aligned with [memory-bank/domain/problem.md](memory-bank/domain/problem.md).

## Rules

- Every issue is expected to include tests as part of completion.
- Keep issues small, atomic, and independently reviewable.
- Complete items in order unless a dependency-free exception is explicit.

## Status Legend

- `[ ]` not started
- `[~]` in progress
- `[x]` done

## 1. Foundation

- [ ] Initialize Rails app shell with homepage and health check
- [ ] Add basic authentication boundary for app users
- [ ] Add `Repository` model and basic CRUD for tracked repositories
- [ ] Add repository fields for GitHub owner/name and default base branch
- [ ] Validate repository uniqueness and required connection fields

## 2. GitHub Integration

- [ ] Add GitHub authentication/token storage needed for repository access
- [ ] Implement GitHub repository metadata fetch
- [ ] Implement branch listing from GitHub
- [ ] Implement branch existence validation for configured repositories
- [ ] Show GitHub connection and repository access status in UI

## 3. Repository Configuration

- [ ] Add repo-level config file discovery
- [ ] Parse config file into `scopes`, `paths`, `source_locale`, and `locales`
- [ ] Show repository configuration status in UI
- [ ] Surface configuration errors clearly on repository page

## 4. Workspace Setup

- [ ] Add `Workspace` model with `repository`, `base_ref`, `head_ref`, `linked_pr`
- [ ] Add workspace creation flow for selecting existing branch as `head_ref`
- [ ] Add workspace creation flow for creating new branch from selected `base_ref`
- [ ] List workspaces for a repository
- [ ] Show workspace summary page with refs and PR status

## 5. Snapshot Loading

- [ ] Implement raw file loading for configured translation paths at a given ref
- [ ] Parse Rails i18n YAML files into normalized structures
- [ ] Flatten translations into entries by `scope`, `key_path`, and `locale`
- [ ] Build snapshot loader for workspace `base_ref`
- [ ] Build snapshot loader for workspace `head_ref`
- [ ] Handle malformed YAML with explicit workspace errors

## 6. Diff and Status

- [ ] Implement diff engine between base and head snapshots
- [ ] Mark entries as `missing` when locale value is absent
- [ ] Mark entries as `outdated` when source changed but translation did not
- [ ] Show `Changed` view for a workspace
- [ ] Add counts for changed, missing, and outdated entries

## 7. Search

- [ ] Show `Search` view from full head snapshot
- [ ] Add search by key path
- [ ] Add search by source value
- [ ] Add search by translation value
- [ ] Add filters by scope and locale
- [ ] Add filters for missing and outdated states

## 8. Review Metadata

- [ ] Add `Metadata` persistence for review state
- [ ] Allow marking a single entry as reviewed
- [ ] Allow unmarking a reviewed entry
- [ ] Record reviewer and reviewed timestamp
- [ ] Show review state in Changed and Search views
- [ ] Add filter for reviewed and unreviewed entries

## 9. Editing

- [ ] Add entry edit form for target locale values
- [ ] Prevent editing source locale values
- [ ] Write edited values back into the correct YAML file structure
- [ ] Preserve untouched YAML content outside edited keys
- [ ] Refresh workspace snapshot and diff after edit
- [ ] Validate YAML remains valid after edit

## 10. Workspace Flow

- [ ] Add navigation to next and previous actionable entry
- [ ] Show workspace pending changes indicator

## 11. Publish

- [ ] Implement publish action to commit workspace changes
- [ ] Implement push action to workspace branch on GitHub
- [ ] Implement PR creation from `head_ref` to `base_ref`
- [ ] Store linked PR URL/number on workspace
- [ ] Prevent duplicate PR creation when linked PR already exists
- [ ] Show publish result and PR link on workspace page

## 12. Operational Safety

- [ ] Add audit-friendly logging for publish actions
- [ ] Add background job wrapper for longer GitHub operations if synchronous requests become too slow
