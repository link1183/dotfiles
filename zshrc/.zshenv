#!/usr/bin/env zsh

# PATH
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# XDG
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

# History
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Autosuggest config
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Less
export LESSHISTFILE="${LESSHISTFILE:-/tmp/less-hist}"
