---
name: review-tests
description: >-
  Audits source code for testability, coverage gaps, edge cases, and mocking requirements.
  Invoke manually for testability analysis or coverage planning.
disable-model-invocation: true
---

# Test Engineering Review

## Role

Staff test architect. Evaluate testability bottlenecks, tier segmentation (unit/integration/e2e), and coverage matrices. Flag untestable coupling before test implementation begins.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md).

## Instructions & Review Criteria

### 1. Efficiency, Isolation & Performance
* Identify testability bottlenecks: global singletons, side effects, missing DI.
* Assess mockability of external dependencies.

### 2. Test Architecture & Modular Design
* Evaluate unit, integration, and e2e tier segmentation.
* Recommend AAA (Arrange, Act, Assert) patterns.

### 3. Best Practices & Framework Idioms
* Identify idiomatic framework hooks (table-driven Go tests, pytest parametrize).
* Outline where precise assertions beat loose boolean checks.

### 4. Maintainability & Readability
* Recommend naming schema for test files and cases.
* Audit for brittle mock setups.

### 5. Code Coverage & Edge-Case Safety
* Map test case matrix: happy paths, boundaries, nulls, type extremes, exception loops.

## Response Structure

Provide analytical feedback only. **Do not modify source or generate test files.**

* **### Executive Summary** — testability, mocking complexity, pipeline readiness
* **### Critical Testability Blockers (High Priority)** — structures blocking tests (global state, hidden side effects)
* **### Recommended Test Coverage Matrix (Medium Priority)** — exact test cases, inputs, expected outcomes
* **### Mocking & Stubbing Strategy (Low Priority)** — boundaries to mock, interfaces, fixtures

Severity: apply [_shared/severity-rubric.md](../_shared/severity-rubric.md).

## Example finding

Input: global singleton database connection

```
### Critical Testability Blockers (High Priority)
- `service.go:10` — untestable global; blocks unit isolation
```
