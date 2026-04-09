---
title: "Loki lacks a way for users to register repositories"
issue_link: "https://github.com/bsboris/loki/issues/4"
status: active
---

## Problem

Users currently cannot create or store a repository record in Loki, so zero repositories can be registered in the system. Without a stored repository record, a user cannot begin repository setup or create a translation workspace tied to a repository.

## Stakeholder

Primary stakeholder: app users who need to register a repository before creating a translation workspace.

Secondary stakeholder: product developers who are blocked on repository-dependent MVP features.

## Context

This task is important now because repository registration is the prerequisite for upcoming MVP flows: GitHub integration, repository configuration, and workspace setup. Repositories are a core domain object in Loki, and these dependent flows cannot proceed until repository records exist in the system.

## Desired outcome

Users can register and view repository records in Loki, and those records exist in the system for use by the next MVP steps: GitHub integration, repository configuration, and workspace creation.
