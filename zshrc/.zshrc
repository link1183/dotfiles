export aurhelper='yay'
export CC="cc"
export CXX="c++"

#  Aliases 
alias c='clear'                                                        # clear terminal
alias la='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias lt='eza --icons=auto --tree'                                     # list folder as tree
alias un='$aurhelper -Rns'                                             # uninstall package
alias up='$aurhelper -Syu'                                             # update system/package/aur
alias pl='$aurhelper -Qs'                                              # list installed package
alias pa='$aurhelper -Ss'                                              # list available package
alias pc='$aurhelper -Sc'                                              # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'                        # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias v='nvim'
alias v.='nvim .'
alias e='exit'
alias lg='lazygit'
alias lz='lazydocker'
alias cat='bat'
alias t='tmux'
alias ta='tmux attach -t'

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

export EDITOR=nvim

# Bind keys: Ctrl-G -> _fuzzy_change_directory
fzf_cd_widget() {
  zle -I
  _fuzzy_change_directory
  zle reset-prompt
}
zle -N fzf_cd_widget
bindkey '^G' fzf_cd_widget

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


# Load Angular CLI autocompletion.
source <(ng completion script)

# pnpm
export PNPM_HOME="/home/agunthe1/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
