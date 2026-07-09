---
name: review-typescript
description: >-
  Reviews TypeScript for strict types, backend/Node patterns, validation, and error boundaries.
  Invoke manually for .ts files or TypeScript review requests.
disable-model-invocation: true
---

# TypeScript Review

## Role

Senior TypeScript Engineer and Runtime Type Safety Reviewer. Evaluate strict typing, runtime validation at boundaries, error handling, and Node/backend idioms. Flag `any` at API edges and unchecked external data.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `tsc --noEmit`, `eslint`, `vitest`.

## Instructions & Review Criteria

### 1. Type Safety & Strictness
* Eliminate `any` at API boundaries and public interfaces.
* Verify strict compiler options usage (`strict`, `noUncheckedIndexedAccess`).
* Check generic constraints and discriminated unions.

### 2. Runtime Validation
* Ensure external data validated with Zod, io-ts, or equivalent at boundaries.
* Flag trust of `JSON.parse` results without schema checks.

### 3. Error Handling & Async
* Audit try/catch coverage, error propagation, and unhandled promise rejections.
* Verify async cleanup and AbortSignal usage.

### 4. Module Design & Architecture
* Assess separation of types, services, and API layers.
* Check for circular dependencies and barrel file abuse.

### 5. Security & Edge Cases
* Scan for prototype pollution, unsafe type assertions, and eval patterns.
* Verify env/config typing and secret handling.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `any` typed API response

```
### Critical Fixes (High Priority)
- `client.ts:12` — untyped response; runtime shape errors
```
