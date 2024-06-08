COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

export ZSH="$HOME/.oh-my-zsh"
export OHMYPOSH="$HOME/.config/oh-my-posh/"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ZSH_TMUX_AUTOSTART=true
plugins=(
  git
  tmux
  zoxide
  web-search
  npm
  node
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  virtualenv
  docker-compose
  fzf
  colored-man-pages
)
source $HOME/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source $HOME/.profile
source $ZSH/oh-my-zsh.sh
source $(dirname $(gem which colorls))/tab_complete.sh
eval "$(oh-my-posh init zsh --config $OHMYPOSH/config.toml)"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# --- Aliases ---
alias cls='clear'
alias rmrf='rm -rf'
alias pcupdate='sudo pacman -Syu && yay -Syu'

alias ls='colorls -A --sd'
alias lc='colorls -lAh --sd'

alias cat="bat"

alias vim='nvim'
alias nivm='nvim'
alias v='nvim'

alias zshc='nvim $HOME/.zshrc'
alias sozsh='source $HOME/.zshrc'

alias cd='z'
alias cdi='zi'
alias cd.='z ..'
alias cd..='z ../..'
alias cd...='z ../../..'
alias cd....='z ../../../..'
