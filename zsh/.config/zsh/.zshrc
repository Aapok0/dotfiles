################################################################################
# PLATFORM DETECTION
################################################################################

OS_TYPE="$(uname -s)"
if [[ "$OS_TYPE" == "Linux" ]]; then
    DISTRO=$(lsb_release -si 2>/dev/null || echo "generic")
else
    DISTRO="darwin"
fi

################################################################################
# HISTORY CONFIG
################################################################################
# Keep 10000 lines of history within the shell and save it to ~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history

# History won't save duplicates or lines starting with space
# Search won't show duplicates and history is shared between terminals
setopt histignorealldups histfindnodups histignorespace sharehistory


################################################################################
# DEFAULT EDITOR
################################################################################
export EDITOR='nvim'
export VISUAL='nvim'


################################################################################
# COMPLETIONS
################################################################################
# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

################################################################################
# PROMPT THEME
################################################################################

# Starship theme - install with: curl -sS https://starship.rs/install.sh | sh
# Available presets:
#   starship preset catppuccin-powerline -o ~/.config/starship.toml
#   starship preset tokyo-night -o ~/.config/starship.toml
#   starship preset gruvbox-rainbow -o ~/.config/starship.toml
eval "$(starship init zsh)"


################################################################################
# PLUGINS
################################################################################


# Fast-Syntax-Highlighting - https://github.com/zdharma-continuum/fast-syntax-highlighting
[[ -f "$ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]] && \
    source "$ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# ZSH-Autosuggestions - https://github.com/zsh-users/zsh-autosuggestions
[[ -f "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
    source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ZSH-Completions - https://github.com/zsh-users/zsh-completions
[[ -d "$ZDOTDIR/plugins/zsh-completions/src" ]] && \
    fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)


################################################################################
# SSH AGENT
################################################################################

# Start SSH agent if not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null 2>&1; then
    eval "$(ssh-agent -s)" > /dev/null
fi


################################################################################
# ALIASES AND KEYBINDINGS
################################################################################

# Use vim keybindings
bindkey -e

# Listing aliases with eza - https://github.com/eza-community/eza
alias ls='eza'
alias ll='eza -laghF --icons --group-directories-first'
alias la='eza -a --icons'
alias tree='eza -aT --icons'

# Editor and interpreter aliases
alias vim='nvim'
alias python='python3'

# Tmux aliases
alias tmuxn='tmux new-session -s'
alias tmuxa='tmux attach-session -t'
alias tmuxnd='tmux new-session -s ${PWD##*/}'

# Terraform alias
alias tf='terraform'

# Color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


################################################################################
# COMMAND LINE TOOLS
################################################################################

# fzf - fuzzy finder
eval "$(fzf --zsh)"

# FZF theme - Catppuccin Mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# fzf-git integration - https://github.com/junegunn/fzf-git.sh
[[ -f "$ZDOTDIR/tools/fzf-git.sh/fzf-git.sh" ]] && \
    source "$ZDOTDIR/tools/fzf-git.sh/fzf-git.sh"

# fd - fast find
# Use fd as the default source for fzf listings
case "$DISTRO" in
    Debian|Ubuntu)
        FD_CMD="fdfind"
        ;;
    *)
        FD_CMD="fd"
        ;;
esac

export FZF_DEFAULT_COMMAND="$FD_CMD --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FD_CMD --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF completion functions - use fd for listing
_fzf_compgen_path() {
    $FD_CMD --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    $FD_CMD --type=d --hidden --exclude .git . "$1"
}

# FZF preview options
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# FZF custom preview function
_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
}

# zoxide - https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init --cmd cd zsh)"

# bat - https://github.com/sharkdp/bat
export BAT_THEME="Catppuccin Mocha"

# man page pager
export MANPAGER='nvim +Man!'

# thefuck - https://github.com/nvbn/thefuck
eval $(thefuck --alias)

# pnpm - Node.js package manager
export PNPM_HOME="${HOME}/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac


################################################################################
# PLATFORM-SPECIFIC CONFIGURATION
################################################################################

case "$DISTRO" in
    Debian|Ubuntu)
        # NVM - Node Version Manager (Debian/Ubuntu package)
        [[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh
        ;;
    Arch|Fedora)
        # NVM - Node Version Manager (user-installed)
        [[ -s "$HOME/.nvm/init-nvm.sh" ]] && source "$HOME/.nvm/init-nvm.sh"
        ;;
    darwin)
        # macOS Homebrew
        [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
        
        # GNU Coreutils for dircolors compatibility
        [[ -d /opt/homebrew/opt/coreutils/libexec/gnubin ]] && \
            export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
        
        # Java (macOS specific)
        [[ -x /usr/libexec/java_home ]] && \
            export JAVA_HOME=$(/usr/libexec/java_home) && \
            export PATH="$JAVA_HOME/bin:$PATH"
        
        # NVM - Node Version Manager (macOS)
        [[ -s "$HOME/.nvm/init-nvm.sh" ]] && source "$HOME/.nvm/init-nvm.sh"
        ;;
esac

# Docker completion - conditional sourcing
command -v docker &> /dev/null && source <(docker completion zsh)


################################################################################
# OPTIONAL DEVELOPMENT TOOLS
################################################################################

# Pyenv - Python version manager
# Install: https://github.com/pyenv/pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

# Tfswitch - Terraform version manager
# Install: https://github.com/warrensbox/terraform-switcher
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Batman - CLI for working with Finago
# Install: place in ~/.local/bin
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Flyctl - Fly.io CLI
# Install: https://fly.io/docs/getting-started/installing-flyctl/
if [[ -d "$HOME/.fly" ]]; then
    export FLYCTL_INSTALL="$HOME/.fly"
    export PATH="$FLYCTL_INSTALL/bin:$PATH"
fi

