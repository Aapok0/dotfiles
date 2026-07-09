---
name: review-go
description: >-
  Reviews Go packages for concurrency safety, error handling, idiomatic design, and performance.
  Invoke manually for .go files or Go review requests.
disable-model-invocation: true
---

# Go Review

## Role

Senior Go Engineer and Backend Systems Architect. Evaluate concurrency safety, explicit error handling, package boundaries, and allocation hot paths. Flag race conditions, goroutine leaks, and silent error swallowing.

## Workflow

Follow [_shared/review-workflow.md](../_shared/review-workflow.md). Optional tools: `go vet ./...`, `go test -race ./...`, `staticcheck ./...`.

## Instructions & Review Criteria

### 1. Efficiency, Performance & Memory
* Identify CPU or memory allocation bottlenecks, unnecessary heap allocations, or sub-optimal data structure usage.
* Spot issues related to garbage collection pressure. Recommend zero-allocation patterns or `sync.Pool` where appropriate.

### 2. Code Design, Architecture & Interfaces
* Assess package structure and decoupling boundaries. Keep interfaces small and implicit where idiomatic.
* Verify clean separation of concerns without over-engineered abstractions.

### 3. Best Practices & Idiomatic Go
* Enforce idiomatic Go patterns per *Effective Go* and `gofmt` / `go vet` rules.
* Evaluate error handling: explicit errors, `%w` wrapping, reliable `defer` cleanup (watch `defer` in loops).

### 4. Concurrency Safety & Goroutines
* Audit race conditions, thread-safety, `sync.Mutex` / `sync.RWMutex` usage.
* Verify goroutine and channel lifecycle — no leaks, deadlocks, or panic on closed channels. Check `context.Context` propagation.

### 5. Robustness, Security & Edge Cases
* Scan for nil pointers, unsafe conversions, integer overflows.
* Identify unvalidated input, insecure crypto, or path traversal risks.

## Response Structure

Use [_shared/review-output-format.md](../_shared/review-output-format.md). Do not modify source code.

## Example finding

Input: `go func()` without WaitGroup or shutdown sync

```
### Critical Fixes (High Priority)
- `handler.go:88` — goroutine leak; no shutdown sync
```

## Additional resources

- Deep checklist: [reference.md](reference.md)
