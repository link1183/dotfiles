# Core command modifications
# Only set if the target commands exist
if (($+commands[bat])); then
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
if (($+commands[grep])); then
	alias grep='grep --color=auto'
	alias egrep='grep -E --color=auto'
	alias fgrep='grep -F --color=auto'
fi

# Navigation (zoxide integration)
if (($+commands[zoxide])); then
	alias cd='z'
	alias cdi='zi'
	alias c.d='z ..'
	alias cd.='z ..'
	alias cd..='z ../..'
	alias cd...='z ../../..'
	alias cd....='z ../../../..'
	alias cd-='z -'
fi

# Neovim related
if (($+commands[nvim])); then
	# FZF integration
	(($+commands[fzf])) && alias inv='nvim $(fzf -m --preview="bat --color=always {}")'

	# Config shortcuts
	alias v.='nvim .'
	alias nvimrc='nvim $HOME/.config/nvim'
	alias nvimrcc='cd $HOME/.config/nvim && nvim $HOME/.config/nvim'

	alias sudovim='sudo -E nvim'

	# ZSH config quick access
	alias zshrc='nvim $HOME/.zshrc'
fi

# Tmux related
if (($+commands[tmux])); then
	alias t='tmux'
	alias ta='t attach -t'
	(($+commands[tmuxifier])) && alias tm='tmuxifier s'
fi

# Git and related tools
if (($+commands[git])); then
	# Lazy tools
	(($+commands[lazygit])) && alias lgt='lazygit'
	(($+commands[lazydocker])) && alias lzd='lazydocker'
	(($+commands[lazynpm])) && alias lzn='lazynpm'

	alias gacp=git add . && git commit -m "$1" && git push

	# Git log with FZF preview
	if (($+commands[fzf])); then
		alias glog="git log --oneline | fzf --preview 'git show --color=always {+1}' | awk '{print \$1}' | xargs -I {} git show {}"
	fi
fi

# System monitoring
alias psmem='ps auxf | sort -nr -k 4 | head -5 | fzf'

# Package management
alias pcupdate='yay --noconfirm'

# Rust development
alias cr='cargo run'

alias mongologs='tail -f ~/mongodb/logs/mongod.log | jq -r '\''.t."$date" + " [" + .s + "] " + .c + ":" + .ctx + " - " + .msg'\'''

alias open='xdg-open'

alias sshfront='ssh -i ~/.ssh/azure azureuser@51.107.24.238'
alias sshback='ssh -i ~/.ssh/azure azureuser@51.107.26.112'
