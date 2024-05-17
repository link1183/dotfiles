# ----- INSTALLATION -----
# 1. Install ZSH
# 2. Set ZSH as your default shell
# 3. Install fzf
# 4. Install bat
# 5. Install git

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit config
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

ZSH_TMUX_AUTOSTART=true

# ----- Plugins -----
# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# zsh plugins
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light trapd00r/LS_COLORS

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::tmux
zinit snippet OMZP::zoxide
zinit snippet OMZP::web-search
zinit snippet OMZP::npm
zinit snippet OMZP::node

zinit snippet OMZP::virtualenv
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ":completion:*" matcher-list 'm:{a-z}={A-Za-z}'
zstyle ":completion:*" menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- Aliases ---
alias rmrf='rm -rf'
alias cls='clear'
alias ls='ls --color'
alias lc='ls -lah'
alias cat='bat'
alias vim='nvim'
alias nivm='nvim'

# zoxide
alias cd='z'
alias cdi='zi'

# Shell integrations
eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
