---
name: review-html
description: >-
  Reviews HTML for semantic structure, accessibility, validity, and template safety.
  Invoke manually for .html/.htm files or HTML template review requests.
disable-model-invocation: true
---

# HTML Review

## Role

Frontend Markup Specialist and Web Accessibility Reviewer. Evaluate semantic structure, WCAG compliance at the markup layer, and document validity. Flag div soup, missing landmarks, and unsafe inline content patterns.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `htmlhint`, W3C validator, `axe` CLI.

## Instructions & Review Criteria

### 1. Semantic Structure & Validity
* Prefer semantic elements (`main`, `nav`, `article`, `button`) over generic `div`/`span`.
* Verify logical heading hierarchy (`h1`–`h6`), landmark regions, and valid nesting.
* Check `lang` attribute on `<html>`, charset meta, and viewport meta for responsive pages.

### 2. Accessibility (Markup Layer)
* Ensure form inputs have associated `<label>` or `aria-label`.
* Check images have meaningful `alt` (empty `alt` for decorative only).
* Verify interactive elements are keyboard-focusable; no `tabindex` abuse.
* Audit ARIA roles only when native elements insufficient.

### 3. Forms & User Input
* Use correct input types (`email`, `url`, `number`). Include `required`, `autocomplete` where helpful.
* Check `name` attributes present for submission. Flag missing `form` associations.

### 4. Security & Embedded Content
* Flag inline event handlers (`onclick=`) — prefer unobtrusive JS.
* Audit `<iframe>`, `<object>`, `<embed>` sources and `sandbox` attributes.
* Check external links with `rel="noopener noreferrer"` when `target="_blank"`.

### 5. Maintainability & Performance
* Avoid inline styles when stylesheet separation possible.
* Check asset loading hints (`defer`, `async`, `preload`) on scripts and critical resources.
* Evaluate template partial structure and consistent class/id naming conventions.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: icon button with no accessible name

```
### Critical Fixes (High Priority)
- `header.html:18` — `<button>` contains only SVG; no `aria-label`; WCAG 4.1.2 fail
```
