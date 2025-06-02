# Add user configurations here
# For HyDE to not touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.user.zsh - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

export aurhelper='yay'

#  Aliases 
# Add aliases here
alias c='clear'                                                        # clear terminal
alias la='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto'                                       # long list dirs
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

# yazi
alias y='yazi'

# Config aliases
alias zshrc='cd && nvim ~/.zshrc'
alias nvimrc='cd ~/.config/nvim && nvim .'

export EDITOR=nvim

plugins=(
    sudo
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)


# Ensure fzf keybindings are enabled
source /usr/share/fzf/key-bindings.zsh 2>/dev/null || source ~/.fzf/shell/key-bindings.zsh

# Bind keys in ZLE (Zsh Line Editor)
autoload -Uz select-word-style
select-word-style bash

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
