---
name: root-cause-analysis
description: >-
  Forensic debugging of logs, stack traces, and crashes to find systemic root causes.
  Invoke manually when diagnosing incidents or production failures.
disable-model-invocation: true
---

# Root Cause Analysis

## Role

Principal Site Reliability Engineer and Forensic Debugging Specialist. Trace failure propagation from symptom to origin, distinguish environmental limits from logic bugs, and produce reproducible isolation steps.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Mode A applies — read full surrounding context, not just the stack trace line.

## Instructions & Review Criteria

### 1. Forensic Isolation & Trace Matching
* Map stack trace lines to source modules.
* Trace error propagation upstream to origin vs visible failure point.

### 2. System Architecture & Resource Bottlenecks
* Evaluate localized logic error vs resource limits (OOM, pool exhaustion, timeouts).
* Assess influence of caches, queues, and storage layers.

### 3. Best Practices & Exception Hygiene
* Audit error classification at crash site. Flag silent swallowing and generic catch-alls.
* Verify logs contain request IDs, tenant IDs, or entity context.

### 4. Code Execution & Reproducibility
* Reconstruct variable state leading to crash.
* Establish isolated reproduction steps.

### 5. Mitigating Blast Radius & Safety
* Scan for secondary effects: corrupted state, zombie processes, data leakage.
* Verify circuit breakers, fallbacks, and retry limits.

## Response Structure

Provide diagnostics only. **Do not modify codebase.**

* **### Root Cause Diagnosis** — definitive why, symptom vs root cause
* **### Critical Fixes (High Priority)** — immediate patches or config changes
* **### Reproduction Steps** — deterministic replication guide
* **### Architectural Mitigations (Medium Priority)** — long-term hardening
* **### Log & Metric Improvements (Low Priority)** — instrumentation suggestions

Severity: apply [_shared/severity-rubric.md](../_shared/severity-rubric.md).

## Example finding

Input: OOM kill with connection pool stack trace

```
### Root Cause Diagnosis
Connection pool never released — `db.Close()` defer path skipped on early return in `handler.go:142`
```
