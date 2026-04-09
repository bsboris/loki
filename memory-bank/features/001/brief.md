---
title: "Establish a verifiable application startup baseline"
issue_link: "https://github.com/bsboris/loki/issues/2"
status: active
---

## Problem

The project does not yet define a verification step that confirms the Rails application has booted and that `GET /` returns HTTP 200. Without that baseline, the team cannot confirm that the application is running before starting or validating subsequent product work.

## Stakeholder

Developers setting up the application locally, reviewers validating setup work, and operators checking that a deployed environment is reachable.

## Context

This task comes from the project foundation work tracked in issue #2, before any MVP product features are built. It is important now because feature development, review, and environment validation depend on a documented startup check.

## Desired outcome

The team can verify application startup by confirming that the application boots and that `GET /` returns HTTP 200 during local setup, review, and deployment validation.
