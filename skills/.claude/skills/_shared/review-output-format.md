# Review Output Format

Default structure for domain review skills. Skills with custom section names (`review-tests`, `root-cause-analysis`) override where noted in their SKILL.md.

Severity tiers: see [severity-rubric.md](severity-rubric.md).

## Standard template

```markdown
### Executive Summary
[Concise overview of health, strengths, and overall assessment]

### Critical Fixes (High Priority)
- `path:line` — [finding and why it matters]

### Refactoring & Optimization (Medium Priority)
- `path:line` — [finding and suggested direction]

### Nitpicks & Style (Low Priority)
- `path:line` — [minor item]
```

## Rules

- Every finding cites `path:line` when the line is known
- Do not modify source code — analytical feedback only
- Group duplicate findings; do not repeat the same issue under multiple headings
- In Mode B (diff review), prefix pre-existing issues with `(pre-existing)`
