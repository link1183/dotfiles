# Core command modifications
# Only set if the target commands exist
if (($ + commands[bat])); then
	alias cat='bat'
else
	alias cat='cat --color=auto'
fi

# Basic shell operations
alias e='exit'
alias cls='clear'
alias rmrf='rm -rf'

# Safety aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Search and grep improvements
if (($ + commands[grep])); then
	alias grep='grep --color=auto'
	alias egrep='grep -E --color=auto'
	alias fgrep='grep -F --color=auto'
fi

# Navigation (zoxide integration)
if (($ + commands[zoxide])); then
	alias cd='z'
	alias cdi='zi'
	alias c.d='z ..'
	alias cd.='z ..'
	alias cd..='z ../..'
	alias cd...='z ../../..'
	alias cd....='z ../../../..'
fi

# Neovim related
if (($ + commands[nvim])); then
	# FZF integration
	(($ + commands[fzf])) && alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

	# Config shortcuts
	alias v.='nvim .'
	alias nvimrc='nvim $HOME/.config/nvim'
	alias nvimrcc='cd $HOME/.config/nvim && nvim $HOME/.config/nvim'

	# ZSH config quick access
	alias zshrc='nvim $HOME/.zshrc'
fi

# Tmux related
if (($ + commands[tmux])); then
	alias t='tmux'
	alias ta='t attach -t'
	(($ + commands[tmuxifier])) && alias tm='tmuxifier s'
fi

# Git and related tools
if (($ + commands[git])); then
	# Lazy tools
	(($ + commands[lazygit])) && alias lgt='lazygit'
	(($ + commands[lazydocker])) && alias lzd='lazydocker'
	(($ + commands[lazynpm])) && alias lzn='lazynpm'

	# Git log with FZF preview
	if (($ + commands[fzf])); then
		alias glog="git log --oneline | fzf --preview 'git show --color=always {+1}' | awk '{print \$1}' | xargs -I {} git show {}"
	fi
fi

# System monitoring
if (($ + commands[ps])) && (($ + commands[fzf])); then
	alias psmem='ps auxf | sort -nr -k 4 | head -5 | fzf'
fi

# Package management
if (($ + commands[yay])); then
	alias pcupdate='yay --noconfirm --noprogressbar'
fi

# Remote connections
if (($ + commands[ssh])); then
	alias rpiadmin='ssh agunthe1@rpi.adrieng.ch'
	alias rpi='ssh github@rpi.adrieng.ch'
fi

# Rust development
if (($ + commands[cargo])); then
	alias cr='cargo run'
fi
