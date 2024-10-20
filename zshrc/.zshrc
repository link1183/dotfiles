#!/bin/sh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
# plug "$HOME/.config/zsh/comp.zsh"
plug "$HOME/.config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh"

# plugins
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/exa" # Must be loaded after supercharge
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"
plug "wintermi/zsh-oh-my-posh"
plug "Freed-Wu/fzf-tab-source"
plug "chivalryq/git-alias"
plug "zap-zsh/sudo"
plug "kutsan/zsh-system-clipboard"
plug "wintermi/zsh-rust"

eval $(oh-my-posh init zsh --config /home/agunthe1/.config/oh-my-posh/config.toml)

eval "$(tmuxifier init -)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval $(keychain --eval --quiet rpi rpiadmin)

. "$HOME/.cargo/env"

zstyle ':fzf-tab:*' fzf-command 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
set -o vi


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# pnpm
export PNPM_HOME="/home/agunthe1/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
