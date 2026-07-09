# Go Deep Checklist

Read when reviewing performance-critical or concurrent Go code.

## Concurrency

- [ ] Shared state protected by mutex or channel discipline
- [ ] No goroutine leaks — every `go` has exit path
- [ ] `context.Context` propagated and honoured for cancellation
- [ ] `defer` not in hot loops (allocation cost)
- [ ] Channels closed by sender only; no send on closed channel

## Error handling

- [ ] Errors never silently discarded (`_ = fn()`)
- [ ] Errors wrapped with `%w` for `errors.Is`/`As` chains
- [ ] Sentinel errors for expected conditions
- [ ] `defer` cleanup handles close errors

## Performance

- [ ] Slice/map capacity pre-allocated when size known
- [ ] `strings.Builder` over `+` concatenation in loops
- [ ] `sync.Pool` for frequently allocated objects in hot paths
- [ ] Benchmark tests for claimed optimizations

## Package design

- [ ] Small interfaces defined by consumer
- [ ] No import cycles
- [ ] `internal/` for non-public packages
- [ ] Exported API documented and stable

## Testing

- [ ] Table-driven tests for multiple cases
- [ ] Race detector clean (`go test -race`)
- [ ] Integration tests behind build tags if slow
- [ ] Mocks at interface boundaries, not concrete types

## Security

- [ ] SQL via parameterized queries
- [ ] File paths cleaned with `filepath.Clean`
- [ ] Crypto from `crypto/` stdlib, not custom
- [ ] Input validated at HTTP/RPC boundaries
