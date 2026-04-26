---
title: Domain Glossary
doc_kind: domain
doc_function: canonical
purpose: Single authoritative definitions for Loki vocabulary used across docs and code. Read when naming features, APIs, or UI copy so terms stay consistent.
derived_from:
  - ../dna/governance.md
status: active
---

# Domain glossary

Terms below are **Loki-specific** or used in a **narrow sense**; ordinary Git or Rails meanings apply unless this file defines otherwise.

## Workspace

A **translation workspace**: one continuous effort on a branch (or head ref), tied to a **repository** and compared against a **base_ref**. Opening a workspace is choosing (or creating) that branch context—not a separate database “project” disconnected from Git.

## Scope

A **configured slice** of the repository’s locale files: which paths belong together, which locale is **source**, and which **locales** are editable. Scopes come from **repo configuration**, not from free-form user folders in the UI.

## Entry

The smallest unit Loki treats as one translatable **cell**: identified by scope + **key_path** (logical path to the string) + **locale**, with a **value** and optional **source_value** from the source locale. Entries are what diffs and snapshots enumerate.

## Snapshot

The **flattened set of entries** visible at a single Git **ref** (for example a branch tip), after applying scope rules and YAML parsing. Used for **search** and “full tree” views as opposed to diff-only views.

## Diff

The **set of changes** between **base_ref** and **head_ref**: which entries were added, removed, or modified, plus enough context to drive “changed” views and publish flows.

## Missing

An **entry** is **missing** when a **supported locale** has **no value** (empty or absent key) while the product still expects a translation for that locale in that scope.

## Outdated

An **entry** is **outdated** when the **source** string changed on **base_ref** (or the configured source of truth) but the **translation** value for a locale was not updated to match that change—review signal, not a Git merge conflict.

## base_ref

The Git **reference** (usually a branch name) Loki compares **against**: “where we started from” or “source of truth for structural/source strings” for diff and outdated detection. Configured per workspace (and may default from repository settings).

## head_ref

The Git **reference** (usually a branch name) where **current work** lives: edits are published here. Together with **base_ref** and **repository**, this defines the workspace.
