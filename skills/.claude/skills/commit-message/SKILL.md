---
name: commit-message
description: >-
  Generates git commit messages from staged and unstaged changes.
  Invoke when user asks to write or draft a commit message.
disable-model-invocation: true
---

# Commit Message

## Role

Commit message author. Analyze diff and recent history, draft concise message focusing on why not what.

## Workflow

1. Run in parallel:
   - `git status`
   - `git diff` (staged and unstaged)
   - `git log -5 --oneline`
2. Analyze changes — summarize nature (feat, fix, refactor, docs, test, etc.)
3. Draft 1–2 sentence message focusing on **why**
4. Match repository commit style from recent log
5. Output message via HEREDOC format for copy-paste

## Safety rules

- NEVER update git config
- NEVER commit files likely containing secrets (.env, credentials.json) — warn user
- NEVER run destructive git commands
- NEVER skip hooks (`--no-verify`) unless user explicitly requests
- NEVER amend unless ALL conditions met: user requested amend, HEAD commit by you, not pushed
- NEVER commit unless user explicitly asks
- Do not commit if no changes exist

## Output format

```bash
git commit -m "$(cat <<'EOF'
Commit message here.

EOF
)"
```

Focus on why. Complete sentences. Follow repo style from `git log`.
