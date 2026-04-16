---
title: "Add daisyUI for styling"
issue_link: "https://github.com/bsboris/loki/issues/62"
status: active
---

## Problem

Loki does not yet have a documented, reusable styling system for common UI elements such as buttons, forms, alerts, and layout surfaces. As a result, each new screen that uses these elements requires developers to define their styling locally, and the application has no single standard for how shared elements should appear.

## Stakeholder

Primary stakeholder: product developers building the web UI, who currently need to style repeated interface elements manually for each screen.

Secondary stakeholder: translators and PMs using Loki, who need repeated interface elements such as forms, actions, and status messages to appear and behave consistently across screens.

## Context

This task comes from GitHub issue #62 and is important now because UI work is expanding beyond the initial Rails scaffold. Upcoming MVP screens will require repeated UI patterns across forms, lists, and actions. Without a shared styling standard, each new screen requires new styling decisions for interface elements that should be consistent across the application.

## Desired outcome

Loki has a standard styling vocabulary for common UI elements that can be applied across current and upcoming screens, so repeated interface patterns are implemented consistently throughout the application.
