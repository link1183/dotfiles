alias e='exit'
alias cls='clear'
alias rmrf='rm -rf'
alias pcupdate='sudo pacman -Syu && yay -Syu'

alias ompupdate='curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin'

alias cat="bat"

# nvim aliases
alias vim='nvim'
alias nivm='nvim'
alias v='nvim'
alias nvimrc='nvim $HOME/.config/nvim'

# tmux
alias t='tmux'

# zsh config files sourcing and editing
alias zshrc='nvim $HOME/.zshrc'
alias sozsh='source $HOME/.zshrc'

# cd stuff
alias cd='z'
alias cdi='zi'
alias c.d='z ..'
alias cd.='z ..'
alias cd..='z ../..'
alias cd...='z ../../..'
alias cd....='z ../../../..'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
