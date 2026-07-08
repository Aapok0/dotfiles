# Review Workflow

Apply this workflow for all domain review skills unless the skill specifies otherwise.

## Scope modes

Pick mode from user intent. PR/diff keywords → Mode B. Otherwise → Mode A.

### Mode A: Full project review (default)

User says: "review this project", "audit the codebase", "review terraform module" — without PR/diff context.

1. **Scope:** All relevant source files in the project (or user-specified subdirectory)
2. **Discovery:** Use glob/file search to map project layout; prioritize entry points, configs, and domain-specific paths from the skill
3. **Context:** Read full files/modules — not diff hunks
4. **Depth:** Structural/architectural issues matter as much as line-level bugs

### Mode B: PR / diff review

User says: "review this PR", "review my changes", "review before merge".

1. **Scope:** `git diff` against base branch (default: merge-base with `main`) — include committed, staged, and unstaged
2. **Context:** Read full file for any changed file, not just the diff hunk
3. **Priority:** Regressions and issues introduced by the change set first; pre-existing issues noted separately under "pre-existing"

## Shared steps (both modes)

1. **Determine mode:** PR/diff keywords → Mode B; else Mode A
2. **Tools:** Run if present and relevant (non-blocking): shellcheck, terraform validate, go vet, ansible-lint, hadolint, tflint, ruff, eslint
3. **Citations:** Every finding includes `path:line` when line is known
4. **Output:** Use [review-output-format.md](review-output-format.md)
5. **Severity:** Apply [severity-rubric.md](severity-rubric.md)
6. **Mode:** Analysis only — do not edit files unless user invokes `fix-from-review`
