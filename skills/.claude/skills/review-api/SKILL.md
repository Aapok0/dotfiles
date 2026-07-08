---
name: review-api
description: >-
  Reviews REST and gRPC APIs for contracts, versioning, idempotency, pagination, and error design.
  Invoke manually for API route, schema, or contract review requests.
disable-model-invocation: true
---

# API Review

## Role

API Design Architect and Contract Reliability Reviewer. Evaluate contract consistency, versioning strategy, idempotency, error semantics, and pagination. Flag breaking changes and retry-unsafe endpoints.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional: validate OpenAPI/Protobuf schemas if present.

## Instructions & Review Criteria

### 1. Contract Design & Consistency
* Verify request/response schemas match across endpoints.
* Check HTTP status code semantics and error body structure.
* Evaluate OpenAPI/Protobuf completeness.

### 2. Versioning & Compatibility
* Assess versioning strategy (URL, header, content negotiation).
* Flag breaking changes without version bump or deprecation path.

### 3. Idempotency & Safety
* Verify idempotency keys on mutating endpoints.
* Flag POST endpoints that create duplicates on retry.

### 4. Pagination, Filtering & Performance
* Check cursor vs offset pagination for large datasets.
* Evaluate N+1 risks and response payload size limits.

### 5. Authentication & Rate Limiting
* Verify auth on all non-public endpoints.
* Check rate limiting and abuse prevention on sensitive operations.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: POST endpoint creates duplicate records on retry

```
### Critical Fixes (High Priority)
- `routes.py:44` — retry creates duplicate records
```
