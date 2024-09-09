alias e='exit'
alias cls='clear'
alias rmrf='rm -rf'
alias pcupdate='yay -Syu --noconfirm --noprogressbar'

alias rpi='ssh agunthe1@rpi.adrieng.ch'

alias ompupdate='curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin'

alias cat="bat"
alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

# nvim aliases
alias v='nvim'
alias v.='nvim .'
alias nvimrc='v $HOME/.config/nvim'
alias nvimrcc='cd $HOME/.config/nvim && v $HOME/.config/nvim'

# tmux
alias t='tmux'
alias ta='t attach -t'
alias tm='tmuxifier s'

alias lgt='lazygit'
alias lzd='lazydocker'
alias lzn='lazynpm'

alias glog="git log --oneline | fzf --preview 'git show --color=always {+1}' | awk '{print $1}' | xargs -I {} git show {}"

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
alias psmem='ps auxf | sort -nr -k 4 | head -5 | fzf'

# rust
alias cr='cargo run'
