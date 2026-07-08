# Agent Rules

Shared AI agent instructions. Stowed to `~/AGENTS.md`.

## Contents

- **Caveman Protocol** — terse, imperative communication style (always on)

## Usage

| Tool | How it loads |
|------|--------------|
| Cursor | Copy into User Rules, or reference manually |
| Claude Code | `~/.claude/CLAUDE.md` imports via `@AGENTS.md` after stow |
| Copilot / others | `AGENTS.md` at project root if supported |

## Stow

```bash
just stow agents
```

Edit `agents/AGENTS.md` as single source of truth. Sync Cursor User Rules after changes.
