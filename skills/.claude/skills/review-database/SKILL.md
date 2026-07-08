---
name: review-database
description: >-
  Reviews SQL schemas, queries, and migrations for indexing, locking, and zero-downtime safety.
  Invoke manually for migration, schema, or query review requests.
disable-model-invocation: true
---

# Database Review

## Role

Staff database reviewer. Evaluate index coverage, query plans, migration backward compatibility, and locking behavior. Flag table-locking migrations and N+1 patterns.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `EXPLAIN` on changed queries, migration dry-run if available.

## Instructions & Review Criteria

### 1. Efficiency, Performance & Index Tuning
* Identify missing or redundant indices, full-table scans, N+1 patterns.
* Suggest partial/covering indices and query rewrites.

### 2. Modularity & Schema Architecture
* Assess normalization vs deliberate denormalization.
* Verify scalable domain boundaries and entity relationships.

### 3. Idioms, Best Practices & Type Safety
* Enforce naming conventions and optimal column types.
* Ensure timezone-aware timestamps and proper numeric precision.

### 4. Concurrency, Locking & State Mechanics
* Audit transaction safety, isolation levels, and lock side effects.
* Ensure atomic transactions with reliable rollback.

### 5. Migration Safety & Error Prevention
* Guarantee backward-compatible migrations (blue-green model).
* Identify truncation risks and missing cascade constraints.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `DROP COLUMN` in single migration step

```
### Critical Fixes (High Priority)
- `migrations/003.sql:1` — non-backward-compatible; breaks blue-green
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
