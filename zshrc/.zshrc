#!/bin/sh
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
  tmux attach || tmux >/dev/null 2>&1
fi

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh"

# plugins
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "zap-zsh/exa"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
plug "MichaelAquilina/zsh-you-should-use"
plug "wintermi/zsh-oh-my-posh"
plug "Freed-Wu/fzf-tab-source"
plug "chivalryq/git-alias"
plug "zap-zsh/sudo"
plug "kutsan/zsh-system-clipboard"
plug "wintermi/zsh-rust"

# keybinds
bindkey '^ ' autosuggest-accept

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# oh-my-posh prompt
eval "$(oh-my-posh init zsh --config $OHMYPOSH/config.toml)"

eval $(thefuck --alias)
eval "$(tmuxifier init -)"
eval "$(zoxide init zsh)"

. "$HOME/.cargo/env"

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


