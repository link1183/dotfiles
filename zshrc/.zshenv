#!/usr/bin/env zsh

function _load_zsh_plugins {
  unset -f _load_zsh_plugins
  # Oh-my-zsh installation path
  zsh_paths=(
    "$HOME/.oh-my-zsh"
    "/usr/local/share/oh-my-zsh"
    "/usr/share/oh-my-zsh"
  )

  for zsh_path in "${zsh_paths[@]}"; do [[ -d $zsh_path ]] && export ZSH=$zsh_path && break; done

  # Load Plugins
  plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    sudo
    zsh-completions
  )

  plugins=($(printf "%s\n" "${plugins[@]}" | sort -u))

  # Defer oh-my-zsh loading until after prompt appears
  typeset -g DEFER_OMZ_LOAD=1
}

# Function to handle initialization errors
function handle_init_error {
  if [[ $? -ne 0 ]]; then
    echo "Error during initialization. Please check your configuration."
  fi
}

function no_such_file_or_directory_handler {
  local red='\e[1;31m' reset='\e[0m'
  printf "${red}zsh: no such file or directory: %s${reset}\n" "$1"
  return 127
}

function _load_omz_on_init() {
  # Load oh-my-zsh when line editor initializes
  if [[ -n $DEFER_OMZ_LOAD ]]; then
    unset DEFER_OMZ_LOAD
    [[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
    ZDOTDIR="${__ZDOTDIR:-$HOME}"
    _load_post_init
  fi
}

# Key: C-e
_fuzzy_edit_search_file_content() {
  local selected_file
  selected_file=$(rg --files-with-matches --hidden --no-ignore --follow "${1:-.}" "$HOME" 2>/dev/null |
    fzf --height=80% --layout=reverse --preview='bat --style=plain --color=always {}' --preview-window=right:60% --cycle)

  if [[ -n "$selected_file" ]]; then
    if command -v "$EDITOR" &>/dev/null; then
      "$EDITOR" "$selected_file"
    else
      echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
      vim "$selected_file"
    fi
  else
    echo "No file selected or search returned no results."
  fi
}

# Key: C-f
_fuzzy_edit_search_file() {
  local initial_query="$1"
  local selected_file
  local fzf_options=(--height=80% --layout=reverse --preview-window=right:60% --cycle)

  if [[ -n "$initial_query" ]]; then
    fzf_options+=("--query=$initial_query")
  fi

  selected_file=$(fd --type f --hidden --exclude .git --exclude node_modules --exclude .venv --exclude target --exclude .cache . . | fzf "${fzf_options[@]}")

  if [[ -n "$selected_file" && -f "$selected_file" ]]; then
    if command -v "$EDITOR" &>/dev/null; then
      "$EDITOR" "$selected_file"
    else
      echo "EDITOR is not specified. using vim.  (you can export EDITOR in ~/.zshrc)"
      vim "$selected_file"
    fi
  else
    return 1
  fi
}

df() {
  if [[ $# -ge 1 && -e "${@: -1}" ]]; then
    duf "${@: -1}"
  else
    duf
  fi
}

function _load_post_init() {
  # Load hydectl completion
  if command -v hydectl &>/dev/null; then
    compdef _hydectl hydectl
    eval "$(hydectl completion zsh)"
  fi

  # Initiate fzf
  if command -v fzf &>/dev/null; then
    eval "$(fzf --zsh)"
  fi

  # Initiate zoxide
  if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh --cmd cd)"
  fi

  # Initiate direnv
  if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
  fi

  # zsh-autosuggestions won't work on first prompt when deferred
  if typeset -f _zsh_autosuggest_start >/dev/null; then
    _zsh_autosuggest_start
  fi

  # User rc file always overrides
  [[ -f $HOME/.zshrc ]] && source $HOME/.zshrc

}

function _load_if_terminal {
  if [ -t 1 ]; then

    unset -f _load_if_terminal

    # Load starship immediatly
    if command -v starship &>/dev/null; then
      eval "$(starship init zsh)"
      export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
      export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
    fi

    # Load plugins
    _load_zsh_plugins

    # Ensure fzf keybindings are enabled
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || source ~/.fzf/shell/key-bindings.zsh

    # Bind keys in ZLE (Zsh Line Editor)
    autoload -Uz select-word-style
    select-word-style bash

    #? Methods to load oh-my-zsh lazily
    __ZDOTDIR="${ZDOTDIR:-$HOME}"
    ZDOTDIR=/tmp
    zle -N zle-line-init _load_omz_on_init # Loads when the line editor initializes

    autoload -Uz add-zsh-hook

    # Some binds won't work on first prompt when deferred
    bindkey '\e[H' beginning-of-line
    bindkey '\e[F' end-of-line
  fi

}

# cleaning up home folder
PATH="$HOME/.local/bin:$PATH"
# XDG_CONFIG_DIR="$HOME/.config"
# XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
# XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
# XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
# XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
#
# # XDG User Directories
# XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
# XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-"$(xdg-user-dir DESKTOP)"}"
# XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-"$(xdg-user-dir DOWNLOAD)"}"
# XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-"$(xdg-user-dir TEMPLATES)"}"
# XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-"$(xdg-user-dir PUBLICSHARE)"}"
# XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-"$(xdg-user-dir DOCUMENTS)"}"
# XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-"$(xdg-user-dir MUSIC)"}"
# XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-"$(xdg-user-dir PICTURES)"}"
# XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-"$(xdg-user-dir VIDEOS)"}"

LESSHISTFILE=${LESSHISTFILE:-/tmp/less-hist}
PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History configuration
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate

# export XDG_CONFIG_HOME XDG_CONFIG_DIR XDG_DATA_HOME XDG_STATE_HOME \
#   XDG_CACHE_HOME XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR \
#   XDG_TEMPLATES_DIR XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR \
#   XDG_MUSIC_DIR XDG_PICTURES_DIR XDG_VIDEOS_DIR \
export SCREENRC ZSH_AUTOSUGGEST_STRATEGY HISTFILE

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export PATH="$PATH:$HOME/go/bin"

_load_if_terminal
