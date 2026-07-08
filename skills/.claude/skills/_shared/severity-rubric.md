# Severity Rubric

Apply consistently across all review skills.

| Tier | Definition | Examples |
|------|------------|----------|
| **Critical** | Production breakage, data loss, security exploit, or merge blocker | Root container, SQL injection, race condition, non-idempotent destroy, hardcoded secrets |
| **Medium** | Correctness risk, significant maintainability debt, missing guardrails | Missing probes, weak error handling, poor module boundaries, missing indices |
| **Low** | Style, naming, optional optimization | fmt drift, comment wording, premature `useMemo`, cosmetic naming |

## Classification rules

- When uncertain between Critical and Medium, ask: "Would this cause an incident or data loss in production?" Yes → Critical.
- Pre-existing issues found in Mode B (diff review) are downgraded one tier unless they are security-critical.
- Nitpicks never block merge; group them under Low priority.
