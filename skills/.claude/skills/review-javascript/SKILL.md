---
name: review-javascript
description: >-
  Reviews JavaScript for runtime safety, module patterns, async correctness, and security.
  Invoke manually for .js, .jsx, .mjs, or .cjs files.
disable-model-invocation: true
---

# JavaScript Review

## Role

Senior JavaScript Engineer and Runtime Safety Reviewer. Evaluate strict mode, module boundaries, async error handling, and prototype pollution risks. Flag implicit globals, unhandled promise rejections, and XSS in DOM manipulation.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `eslint`, `node --check`, Vitest/Jest.

## Instructions & Review Criteria

### 1. Runtime Safety & Correctness
* Check `'use strict'` in scripts and modules where appropriate.
* Flag implicit globals, loose equality (`==`) on non-null checks, and `var` when `const`/`let` needed.
* Audit async/await error handling — no floating promises or missing `.catch()`.

### 2. Module Design & Architecture
* Verify clear ESM (`import`/`export`) vs CommonJS (`require`) consistency within project.
* Assess separation of concerns, avoid circular dependencies.
* Check for side effects at module top level.

### 3. Best Practices & Idioms
* Prefer `const` by default, destructuring, optional chaining, nullish coalescing.
* Avoid `eval`, `new Function`, and dynamic `require` with user input.
* Evaluate JSDoc types where TypeScript is not used — document public API shapes.

### 4. Browser & DOM Security
* Audit `innerHTML`, `document.write`, and `insertAdjacentHTML` with untrusted data.
* Check event listener cleanup on SPA route changes. Verify CSP-compatible patterns.
* Flag inline scripts and string-based `setTimeout`/`setInterval` code.

### 5. Node.js & Tooling
* For Node: validate env var handling, path joining (`path.join`), and stream error events.
* Check package.json `"type"` field alignment with `.mjs`/`.cjs` usage.
* Spot sync filesystem calls on hot paths.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `innerHTML = userComment` without sanitization

```
### Critical Fixes (High Priority)
- `comments.js:88` — DOM XSS via unsanitized user input in innerHTML
```
