# Database Deep Checklist

Read when reviewing production schemas, migrations, or query performance.

## Indexing

- [ ] Foreign keys indexed
- [ ] Composite indices match query filter order
- [ ] Partial indices for filtered queries (e.g. `WHERE active = true`)
- [ ] Covering indices for read-heavy queries
- [ ] No redundant indices (left-prefix duplicates)

## Query performance

- [ ] `EXPLAIN` reviewed for changed queries
- [ ] No N+1 — batch or join instead
- [ ] Pagination via cursor/keyset, not `OFFSET` on large tables
- [ ] No `SELECT *` in hot paths
- [ ] Implicit type conversions avoided

## Migration safety (blue-green)

- [ ] Add column: nullable or with default first
- [ ] Rename column: add new → dual-write → migrate → drop old
- [ ] Drop column: stop reading → deploy → drop in later migration
- [ ] Index creation: `CONCURRENTLY` on PostgreSQL for large tables
- [ ] Backward compatible with previous app version

## Locking & concurrency

- [ ] Long transactions avoided
- [ ] `SELECT FOR UPDATE` only when necessary
- [ ] Migration lock timeout configured
- [ ] Optimistic locking (`version` column) for concurrent updates

## Data integrity

- [ ] Foreign key constraints with appropriate `ON DELETE`
- [ ] `NOT NULL` on required fields
- [ ] Check constraints for enum-like columns
- [ ] Unique constraints at DB level, not app-only

## Security

- [ ] Parameterized queries only — no string concatenation
- [ ] Least-privilege DB users per service
- [ ] Sensitive columns encrypted at rest
- [ ] Audit logging for admin operations

## Schema design

- [ ] Consistent naming (snake_case, plural tables)
- [ ] Timezone-aware timestamps (`timestamptz`)
- [ ] Appropriate numeric precision
- [ ] UUID vs serial ID choice documented
