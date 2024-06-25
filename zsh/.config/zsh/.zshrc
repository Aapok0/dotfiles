# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$PATH


### HISTORY CONFIG
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/.zsh_history

# History won't save duplicates or lines starting with space, search won't show duplicates and history is shared between terminals
setopt histignorealldups histfindnodups histignorespace sharehistory #incappendhistory = history is incrementally appended


### DEFAULT EDITOR
export EDITOR='nvim'
export VISUAL='nvim'


### COMPLETIONS
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


### PROMPT THEME
# Spaceship theme - install from https://github.com/spaceship-prompt/spaceship-prompt
#source $ZDOTDIR/themes/spaceship-prompt/spaceship.zsh-theme

# Spaceship config - https://spaceship-prompt.sh/config/prompt/#Prompt-order
#SPACESHIP_PROMPT_ORDER=(
#    user          # Username section
#    dir           # Current directory section
#    host          # Hostname section
#    git           # Git section (git_branch + git_status)
#    exec_time     # Execution time
#    line_sep      # Line break
#    #vi_mode       # Vi-mode indicator
#    jobs          # Background jobs indicator
#    exit_code     # Exit code section
#    char          # Prompt character
#)
#SPACESHIP_USER_SHOW=always
#SPACESHIP_PROMPT_ADD_NEWLINE=true
#SPACESHIP_CHAR_SYMBOL="❯"
#SPACESHIP_CHAR_SUFFIX=" "

# PowerLevel10K theme - install from https://github.com/romkatv/powerlevel10k
# Recommended to use MesloLGS NF font https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k
source $ZDOTDIR/themes/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

### PLUGINS

# Fast-Syntax-Highlighting - install from https://github.com/zdharma-continuum/fast-syntax-highlighting
source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ZSH-Autosuggestions - install from https://github.com/zsh-users/zsh-autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ZSH-Completions - install from https://github.com/zsh-users/zsh-completions
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

### ALIASES AND KEYBINDINGS
# Use vim keybindings even if EDITOR is set to something else
bindkey -e

# Enable color support of ls and grep
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Listing aliases with ls
#alias ll='ls -lahF --group-directories-first'
#alias la='ls -A'
#alias l='ls -CF'

# Listing aliases with eza
alias ls='eza'
alias ll='eza -laghF --icons --group-directories-first'
alias la='eza -a --icons'

# Alias tree to exa
alias tree='exa -aFT --icons'

# Always use nvim
alias vim='nvim'

# Alias cat to batcat
#alias cat='batcat'
# Have batcat print longer files to terminal
#export BAT_PAGER=never

# Alias python3 to python
alias python='python3'

# New tmux session with name
alias tmuxn='tmux new-session -s'
# Attach to tmux session with name
alias tmuxa='tmux attach-session -t'
# New tmux session named as the directory currently in
alias tmuxnd='tmux new-session -s ${PWD##*/}'

# Shorter alias for terraform
alias tf='terraform'


### COMMAND LINE TOOLS
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Comment above and uncomment below for mac
#eval "$(fzf --zsh)"
# Theme - catpuccin mocha https://github.com/catppuccin/fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# fzf-git - install from https://github.com/junegunn/fzf-git.sh
source $ZDOTDIR/tools/fzf-git.sh/fzf-git.sh

# fd
# Use fd instead of find in fzf (change fdfind to fd in mac or non debian linux)
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"
# Use fd for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --exclude .git . "$1"
}
# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

# Use bat to show a preview of the file in fzf
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
# Use eza to show a tree view of the files in directories in fzf
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf preview options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
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

# zoxide - this also aliases cd to z
eval "$(zoxide init --cmd cd zsh)"

# batcat
# theme - catpuccin mocha - install from https://github.com/catppuccin/bat
export BAT_THEME="Catppuccin Mocha"

# thefuck
eval $(thefuck --alias)

# add flyctl to PATH
export FLYCTL_INSTALL="${HOME}/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# pipx (Ansible)
# Created by `pipx` on 2023-08-17 07:33:49
export PATH="$PATH:${HOME}/.local/bin"

# bin path for tfswitch
export PATH="${HOME}/bin:$PATH"
