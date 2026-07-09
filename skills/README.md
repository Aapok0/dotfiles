# Skills

AI agent skills for code review, debugging, and workflow automation.

Stowed via `just stow skills` to `~/.claude/skills/`. Cursor discovers skills from `~/.claude/skills/` via compatibility path.

Shared agent rules live in `../agents/AGENTS.md`, stowed to `~/AGENTS.md`.

## Usage

Invoke skills manually (e.g. `/review-go`, "use review-terraform"). Most review skills have `disable-model-invocation: true`.

- **Full project review:** "review this project" → Mode A (all relevant files)
- **PR/diff review:** "review my changes" → Mode B (git diff scope)
- **Auto-routing:** use `review-router` for multi-domain reviews

## Cursor user rule

Sync caveman content from `agents/AGENTS.md` into Cursor User Rules for always-on behavior in Cursor.
