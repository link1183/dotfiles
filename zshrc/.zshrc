export CC="cc"
export CXX="c++"

#  Aliases 
alias c='clear'                                                        # clear terminal
alias la='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias lt='eza --icons=auto --tree'                                     # list folder as tree
alias v='nvim'
alias v.='nvim .'
alias e='exit'
alias lg='lazygit'
alias lz='lazydocker'
alias cat='bat'
alias t='tmux'
alias ta='tmux attach -t'
alias up='yay -Syu'

# # Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

alias rmrf='rm -rf'

# yazi
alias y='yazi'

# Config aliases
alias zshrc='cd && nvim ~/.zshrc'
alias nvimrc='cd ~/.config/nvim && nvim .'

# Ctrl-F -> _fuzzy_edit_search_file
fzf_edit_file_widget() {
  zle -I
  _fuzzy_edit_search_file
  zle reset-prompt
}
zle -N fzf_edit_file_widget
bindkey '^F' fzf_edit_file_widget

# Ctrl-E -> _fuzzy_edit_search_file_content
fzf_edit_content_widget() {
  zle -I
  _fuzzy_edit_search_file_content
  zle reset-prompt
}
zle -N fzf_edit_content_widget
bindkey '^E' fzf_edit_content_widget

eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1

eval "$(direnv hook zsh)"
