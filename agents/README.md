# Agent Rules

Shared AI agent instructions. Stowed to `~/AGENTS.md`.

Domain-specific workflows (code review, commits, PRs) live in [`skills/`](../skills/) — not here.

## Contents

[`AGENTS.md`](AGENTS.md) sections:

| Section | Purpose |
|---------|---------|
| **Caveman Protocol** | Terse, imperative style (always on); full prose for PR reviews, postmortems, user-facing docs |
| **Execution** | Run commands, investigate, retry on failure |
| **Code changes** | Minimal diff, match conventions, reuse existing code, no over-engineering |
| **Safety** | Secrets, destructive git, destructive system ops |
| **Skills** | Manual skill invocation; pointer to review-router and workflow skills |
| **Code references** | `startLine:endLine:path` citation format |
| **Context** | `~/Workspace`, Arch desktop / Fedora laptop, dotfiles via stow + `just` |

## Usage

| Tool | How it loads |
|------|--------------|
| Cursor | User Rules (sync from `AGENTS.md` after edits) |
| Claude Code | `~/.claude/CLAUDE.md` imports via `@AGENTS.md` after stow |
| Copilot / others | `AGENTS.md` at project root if supported |

## Stow

Included in `just stow-all` / `just install`, or alone:

```bash
just stow agents
```

Edit [`agents/AGENTS.md`](AGENTS.md) as single source of truth. Sync Cursor User Rules after changes.
