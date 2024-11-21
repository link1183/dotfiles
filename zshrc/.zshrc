#!/bin/sh

# zmodload zsh/zprof

# Load zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Load completion system in background
{
    # Load compinit only once a day
    autoload -Uz compinit
    if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
        compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"
    else
        compinit -C
    fi

    # Compile zcompdump if modified
    if [[ -s "${ZDOTDIR:-$HOME}/.zcompdump" && (! -s "${ZDOTDIR:-$HOME}/.zcompdump.zwc" || "${ZDOTDIR:-$HOME}/.zcompdump" -nt "${ZDOTDIR:-$HOME}/.zcompdump.zwc") ]]; then
        zcompile "${ZDOTDIR:-$HOME}/.zcompdump"
    fi
} &!

# Completion optimization
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' cache-path $HOME/.cache/zsh/cache
zstyle ':fzf-tab:*' fzf-command fzf

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY HIST_REDUCE_BLANKS HIST_VERIFY

# Load local config files in correct order
# Load exports first (no delay)
zinit snippet $HOME/.config/zsh/aliases.zsh
zinit snippet $HOME/.config/zsh/exports.zsh

# Load functions before aliases since aliases might use functions
zinit snippet $HOME/.config/zsh/fn.zsh

# Finally load theme
zinit ice wait"0" lucid
zinit snippet $HOME/.config/zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh

# Plugin loading with optimizations
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Additional plugins with lazy loading
zinit wait lucid for \
    esc/conda-zsh-completion \
    hlissner/zsh-autopair \
    zap-zsh/supercharge \
    zap-zsh/fzf \
    Aloxaf/fzf-tab \
    zap-zsh/exa \
    zsh-users/zsh-history-substring-search \
    MichaelAquilina/zsh-you-should-use \
    Freed-Wu/fzf-tab-source \
    chivalryq/git-alias \
    zap-zsh/sudo \
    kutsan/zsh-system-clipboard \
    wintermi/zsh-rust

# Initialize tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(keychain --eval --quiet rpi rpiadmin)"

# Vi mode
set -o vi

# pnpm setup (conditional)
if (( $+commands[pnpm] )); then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi

# zprof
