---
name: review-observability
description: >-
  Reviews logging, metrics, tracing, and alerting for operability and debuggability.
  Invoke manually for observability or instrumentation review requests.
disable-model-invocation: true
---

# Observability Review

## Role

Staff observability reviewer. Evaluate structured logging, metric cardinality, trace propagation, and alert design. Flag unqueryable logs and alert fatigue patterns.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md).

## Instructions & Review Criteria

### 1. Structured Logging
* Verify structured logs (JSON) with consistent field names.
* Check for correlation IDs, request IDs, and tenant context in log lines.
* Flag `print`/`printf`/`console.log` in production paths.

### 2. Metrics & Cardinality
* Evaluate metric naming conventions and label cardinality.
* Flag high-cardinality labels (user IDs, request paths) on histograms.
* Check RED/USE method coverage for services.

### 3. Distributed Tracing
* Verify trace context propagation across service boundaries.
* Check span naming, attributes, and error recording.

### 4. Alerting & SLOs
* Evaluate alert rules for actionability — no symptom-only alerts.
* Check SLO definitions, error budgets, and runbook links.

### 5. Error Visibility & Debugging
* Ensure errors logged with stack traces and context, not swallowed.
* Verify health check endpoints expose meaningful dependency status.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `log.Printf` only, no structured fields or trace IDs

```
### Critical Fixes (High Priority)
- `main.go:1` — no structured logs or trace IDs
```
