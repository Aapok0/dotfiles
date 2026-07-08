---
name: create-pr
description: >-
  Creates a GitHub pull request from current branch using gh CLI.
  Invoke when user asks to create or open a PR.
disable-model-invocation: true
---

# Create PR

## Role

PR author. Draft title and body from branch diff and commits, push if needed, create PR via `gh`.

## Workflow

1. Run in parallel:
   - `git status`
   - `git diff` against base branch (default: merge-base with `main`)
   - `git log` vs base branch
   - Check remote tracking (`git branch -vv`)
2. Detect existing test/CI setup from repo:
   - `.github/workflows/` — note which checks run on PR
   - `justfile`, `Makefile`, `package.json` scripts — find test/lint/smoke targets
3. Draft PR title and body:
   - **Summary:** 1–3 bullet points of what changed and why
   - **Testing:** reference CI checks that will run automatically; list local commands only if relevant (`just test`, `npm test`, etc.) or if change needs manual verification CI won't cover
   - Omit generic test checklist when CI already covers the repo
4. PR body uses **full prose**
5. Push if branch not on remote:
   - `git push -u origin HEAD`
   - Ask before push if user didn't explicitly say "create PR"
6. Create PR:
   ```bash
   gh pr create --title "..." --body "$(cat <<'EOF'
   ## Summary
   - ...

   ## Testing
   CI: [workflows/checks that run on PR]
   Local: [commands run or recommended, if any]
   EOF
   )"
   ```
7. Return PR URL

## Safety rules

- NEVER force-push to main/master — warn if requested
- NEVER skip hooks unless user explicitly requests
- NEVER update git config
- Do not push without user confirmation if situation is ambiguous
- Check branch tracks remote before assuming push state

## Requirements

- `gh` CLI authenticated
- On a feature branch, not directly on `main`/`master` (warn if so)
