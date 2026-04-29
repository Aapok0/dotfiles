# Starship Configuration

Custom [Starship](https://starship.rs/) prompt theme called **Dusk** — a muted, pastel-toned powerline prompt designed for dark terminals.

## Theme

The Dusk palette uses warm and cool muted tones optimized for very dark backgrounds (~`#1e1e2e`):

| Segment | Color | Hex |
|---------|-------|-----|
| OS / Username | Slate | `#4a5468` |
| Directory | Amber | `#a88a68` |
| Git | Sage | `#609880` |
| Languages | Twilight | `#607a9a` |
| Cloud / Infra | Muted Dusk | `#3e3e54` |
| Time | Deep Dusk | `#282838` |
| Text | Parchment | `#ddd9d0` |
| Cloud text | Steel | `#8098b0` |
| Success | Soft Sage | `#88a888` |
| Errors / Root | Dusty Rose | `#bf7a7a` |
| Vim modes | Wisteria | `#b49ec4` |

Segment transitions use rounded caps at the start and end with slanted right separators between sections.

## Segments

The prompt bar displays (left to right):

1. **OS icon** + **username** (+ hostname on SSH)
2. **Directory** (truncated to 4 parents)
3. **Git branch** + **status** (with counts)
4. **Language version** (C, C++, Rust, Go, Node.js, PHP, Java, Kotlin, Haskell, Python)
5. **Cloud/infra** — Docker, Conda, Pixi, Kubernetes, Terraform, AWS, Azure, GCloud
6. **Time**

After the bar: command duration (if >2s), exit status (on failure), sudo indicator.

Second line: prompt character (changes color on error, adapts to vim modes).

## Requirements

- [Starship](https://starship.rs/) prompt
- A [Nerd Font](https://www.nerdfonts.com/) — the config uses powerline glyphs and Nerd Font icons

### Font Setup

| Platform | Package |
|----------|---------|
| macOS | `brew install --cask font-jetbrains-mono-nerd-font` |
| Arch | `sudo pacman -S ttf-jetbrains-mono-nerd` |
| Debian/Ubuntu | Download from [nerdfonts.com](https://www.nerdfonts.com/font-downloads) |

Set your terminal font to **"JetBrainsMono Nerd Font"** — see the [kitty README](../kitty/README.md#font) for terminal-specific font setup.

## Setup

Use [stow](https://www.gnu.org/software/stow/) to symlink:

```bash
cd ~/path/to/dotfiles
stow -vRt $HOME starship
```

This creates `~/.config/starship.toml` → `dotfiles/starship/.config/starship.toml`.

## Known Issues

- `fish_style_pwd_dir_length` is disabled due to [starship#7086](https://github.com/starship/starship/issues/7086) — it conflicts with `truncate_to_repo` and `truncation_length`.
