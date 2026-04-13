---
title: "Enable GitHub repository connection"
issue_link: "https://github.com/bsboris/loki/issues/8"
status: active
---

## Problem

Users cannot connect their GitHub repositories to Loki, which prevents them from accessing translation files stored in GitHub. There is currently no way to establish this connection or verify that a repository is accessible.

## Stakeholder

Developers and translators who need to connect Loki to their GitHub repositories to begin working with translations. This is a prerequisite for all workspace-based translation workflows.

## Context

This task is part of the "GitHub Integration" section (section 2) in the project backlog. It follows the foundation work where the `Repository` model was established with owner/name fields. This feature enables the core GitHub integration layer that subsequent features (branch listing, workspace creation, file loading) will depend on.

## Desired outcome

Users can successfully connect their GitHub repositories to Loki and the system can verify accessibility and readiness for translation workflows.
