# gitconfig

A comprehensive Git configuration with sensible defaults.

## Installation

### Link the config
```bash
ln -s /path/to/dotfiles/gitconfig/.gitconfig ~/.gitconfig
```

### Local user config (required)
Create `~/.config/git/config.local` with your user info:
```ini
[user]
    name = Your Name
    email = your@email.com
```

This keeps personal credentials out of the public repository and won't cause diffs.

## Requirements

### Delta (git-delta)

A syntax-highlighting pager for Git diffs. Install based on your system:

**Arch**
```bash
sudo pacman -S git-delta
```

**Debian/Ubuntu**
```bash
# Download the latest release from https://github.com/dandavison/delta/releases
dpkg -i git-delta_*.deb
```

**Fedora/RHEL**
```bash
sudo dnf install git-delta
```

**MacOS**
```bash
brew install git-delta
```

## Configuration Highlights

### Core Features
- **Smart diffs** — Uses the `histogram` algorithm for more intelligent change detection
- **Color-moved code** — Highlights code movement differently from additions/deletions
- **Better merges** — Includes base context in merge conflicts (diff3 style)
- **Auto-upstream** — `git push` automatically sets up tracking branches
- **Auto-squash** — Support for `fixup!` and `squash!` commit messages
- **Fetch pruning** — Keeps remote references clean (set to false to preserve local branches)

### Delta Pager
- Side-by-side diffs
- Navigable sections with `n` and `N` keys
- Syntax highlighting for code changes

## Useful Aliases

| Alias | Action |
|-------|--------|
| `st` | `status` |
| `co` | `checkout` |
| `sw` | `switch` |
| `save` | Stage all and commit |
| `ci` | Commit with message |
| `amend` | Amend last commit (no edit) |
| `undo` | Undo last commit (keep changes) |
| `unstage` | Unstage files |
| `discard` | Discard changes in working directory |
| `reset-author` | Fix author on last commit |
| `fixup` | Create fixup commit for autosquash |
| `br` | List branches by recent date |
| `current` | Show current branch name |
| `default` | Switch to default branch (main) |
| `last` | Show last commit with stats |
| `lol` | Pretty commit log graph |
| `glog` | All branches commit graph |
| `changed` | Files changed from upstream |
| `ahead` | Commits ahead of upstream |
| `behind` | Commits behind upstream |
| `unstash-list` | Better formatted stash list |
| `rdiff` | Fetch and show commits ahead |
| `alias` | Show all git aliases |
