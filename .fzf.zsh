# Setup fzf
# ---------
if [[ ! "$PATH" == */home/agunthe1/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/agunthe1/.fzf/bin"
fi

eval "$(fzf --zsh)"
