#!/usr/bin/env zsh
#!          ░▒▓
#!        ░▒▒░▓▓
#!      ░▒▒▒░░░▓▓           ___________
#!    ░░▒▒▒░░░░░▓▓        //___________/
#!   ░░▒▒▒░░░░░▓▓     _   _ _    _ _____
#!   ░░▒▒░░░░░▓▓▓▓▓ | | | | |  | |  __/
#!    ░▒▒░░░░▓▓   ▓▓ | |_| | |_/ /| |___
#!     ░▒▒░░▓▓   ▓▓   \__  |____/ |____/    ▀█ █▀ █░█
#!       ░▒▓▓   ▓▓  //____/                █▄ ▄█ █▀█

# HyDE's ZSH env configuration
# This file is sourced by ZSH on startup
# And ensures that we have an obstruction-free ~/.zshrc file
# This also ensures that the proper HyDE $ENVs are loaded

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
  hyde_plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
  plugins+=("${plugins[@]}" "${hyde_plugins[@]}")
  # Deduplicate plugins
  plugins=("${plugins[@]}")
  plugins=($(printf "%s\n" "${plugins[@]}" | sort -u))
  # Defer oh-my-zsh loading until after prompt appears
  typeset -g DEFER_OMZ_LOAD=1
}

# Function to display a slow load warning
# the intention is for hyprdots users who might have multiple zsh initialization
function _slow_load_warning {
  local lock_file="/tmp/.hyde_slow_load_warning.lock"
  local load_time=$SECONDS

  # Check if the lock file exists
  if [[ ! -f $lock_file ]]; then
    # Create the lock file
    touch $lock_file

    # Display the warning if load time exceeds the limit
    time_limit=3
    if ((load_time > time_limit)); then
      cat <<EOF
    ⚠️ Warning: Shell startup took more than ${time_limit} seconds. Consider optimizing your configuration.
        1. This might be due to slow plugins, slow initialization scripts.
        2. Duplicate plugins initialization.
            - navigate to ~/.zshrc and remove any 'source ZSH/oh-my-zsh.sh' or
                'source ~/.oh-my-zsh/oh-my-zsh.sh' lines.
            - HyDE already sources the oh-my-zsh.sh file for you.
            - It is important to remove all HyDE related
                configurations from your .zshrc file as HyDE will handle it for you.
            - Check the '.zshrc' file from the repo for a clean configuration.
                https://github.com/HyDE-Project/HyDE/blob/master/Configs/.zshrc

    For more information, on the possible causes of slow shell startup, see:
        🌐 https://github.com/HyDE-Project/HyDE/wiki

EOF
    fi
  fi
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
  # Load oh-my-zsh when line editor initializes // before user input
  if [[ -n $DEFER_OMZ_LOAD ]]; then
    unset DEFER_OMZ_LOAD
    [[ -r $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
    ZDOTDIR="${__ZDOTDIR:-$HOME}"
    _load_post_init
  fi
}

# Key: C-g
_fuzzy_change_directory() {
  local initial_query="$1"
  local selected_dir
  local fzf_options=('--preview=ls -p {}' '--preview-window=right:60%' '--height=80%' '--layout=reverse' '--cycle')

  if [[ -n "$initial_query" ]]; then
    fzf_options+=("--query=$initial_query")
  fi

  selected_dir=$(fd --type d --hidden --follow --no-ignore \
    --exclude .git --exclude node_modules --exclude .venv --exclude target --exclude .cache \
    "." "$HOME" 2>/dev/null |
    fzf "${fzf_options[@]}")

  if [[ -n "$selected_dir" && -d "$selected_dir" ]]; then
    cd "$selected_dir" || return 1
  else
    return 1
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

_df() {
  if [[ $# -ge 1 && -e "${@: -1}" ]]; then
    duf "${@: -1}"
  else
    duf
  fi
}

function _load_post_init() {
  #! Never load time consuming functions here
  autoload -U compinit && compinit

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

    # Currently We are loading Starship and p10k prompts on start so users can see the prompt immediately

    if command -v starship &>/dev/null; then
      # ===== START Initialize Starship prompt =====
      eval "$(starship init zsh)"
      export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
      export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
    # ===== END Initialize Starship prompt =====
    fi

    # Optionally load user configuration // useful for customizing the shell without modifying the main file
    if [[ -f $HOME/.hyde.zshrc ]]; then
      source $HOME/.hyde.zshrc # for backward compatibility
    fi

    # Load plugins
    _load_zsh_plugins

    # Load zsh hooks module once

    #? Methods to load oh-my-zsh lazily
    __ZDOTDIR="${ZDOTDIR:-$HOME}"
    ZDOTDIR=/tmp
    zle -N zle-line-init _load_omz_on_init # Loads when the line editor initializes // The best option

    #  Below this line are the commands that are executed after the prompt appears

    autoload -Uz add-zsh-hook
    # add-zsh-hook zshaddhistory load_omz_deferred # loads after the first command is added to history
    # add-zsh-hook precmd load_omz_deferred # Loads when shell is ready to accept commands
    # add-zsh-hook preexec load_omz_deferred # Loads before the first command executes

    # TODO: add handlers in pm.sh
    # for these aliases please manually add the following lines to your .zshrc file.(Using yay as the aur helper)
    # pc='yay -Sc' # remove all cached packages
    # po='yay -Qtdq | ${PM_COMMAND[@]} -Rns -' # remove orphaned packages

    # Warn if the shell is slow to load
    add-zsh-hook -Uz precmd _slow_load_warning

    alias c='clear' \
      in='${PM_COMMAND[@]} install' \
      un='${PM_COMMAND[@]} remove' \
      up='${PM_COMMAND[@]} upgrade' \
      pl='${PM_COMMAND[@]} search installed' \
      pa='${PM_COMMAND[@]} search all' \
      vc='code' \
      fastfetch='fastfetch --logo-type kitty' \
      ..='cd ..' \
      ...='cd ../..' \
      .3='cd ../../..' \
      .4='cd ../../../..' \
      .5='cd ../../../../..' \
      mkdir='mkdir -p' \
      ffec='_fuzzy_edit_search_file_content' \
      ffcd='_fuzzy_change_directory' \
      ffe='_fuzzy_edit_search_file' \
      df='_df'

    # Some binds won't work on first prompt when deferred
    bindkey '\e[H' beginning-of-line
    bindkey '\e[F' end-of-line

  fi

}

#? Override this environment variable in ~/.zshrc

# cleaning up home folder
PATH="$HOME/.local/bin:$PATH"
XDG_CONFIG_DIR="${XDG_CONFIG_DIR:-"$(xdg-user-dir CONFIG)"}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-$XDG_DATA_HOME:/usr/local/share:/usr/share}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# XDG User Directories
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$(xdg-user-dir CONFIG)"}"
XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-"$(xdg-user-dir DESKTOP)"}"
XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-"$(xdg-user-dir DOWNLOAD)"}"
XDG_TEMPLATES_DIR="${XDG_TEMPLATES_DIR:-"$(xdg-user-dir TEMPLATES)"}"
XDG_PUBLICSHARE_DIR="${XDG_PUBLICSHARE_DIR:-"$(xdg-user-dir PUBLICSHARE)"}"
XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-"$(xdg-user-dir DOCUMENTS)"}"
XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-"$(xdg-user-dir MUSIC)"}"
XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-"$(xdg-user-dir PICTURES)"}"
XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-"$(xdg-user-dir VIDEOS)"}"

LESSHISTFILE=${LESSHISTFILE:-/tmp/less-hist}
PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# History configuration // explicit to not nuke history
HISTFILE=${HISTFILE:-$HOME/.zsh_history}
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate

# HyDE Package Manager
PM_COMMAND=(hyde-shell pm)

export XDG_CONFIG_HOME XDG_CONFIG_DIR XDG_DATA_HOME XDG_STATE_HOME \
  XDG_CACHE_HOME XDG_DESKTOP_DIR XDG_DOWNLOAD_DIR \
  XDG_TEMPLATES_DIR XDG_PUBLICSHARE_DIR XDG_DOCUMENTS_DIR \
  XDG_MUSIC_DIR XDG_PICTURES_DIR XDG_VIDEOS_DIR \
  SCREENRC ZSH_AUTOSUGGEST_STRATEGY HISTFILE

_load_if_terminal
