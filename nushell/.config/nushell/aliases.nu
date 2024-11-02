# Alias cat to bat
def --env cat [...args] {
  if (which bat | is-empty) {
    ^cat --color=auto ...$args
  } else {
    bat ...$args
  }
}

# Basic shell operations
alias e = exit
alias cls = clear
alias rmrf = rm -rf

# Safety aliases
alias cp = cp -i
alias mv = mv -i
alias rm = rm -i

# Grep
alias grep = grep --color=auto
alias egrep = grep -E --color=auto
alias fgrep = grep -F --color=auto

# Navigation
alias cd = z
alias cdi = zi
alias c.d = z ..
alias cd. = z ../..
alias cd.. = z ../../..
alias cd... = z ../../../..
alias cd.... = z ../../../../..

# Nvim related
def inv [] {
    let selected = (fzf -m --preview="bat --color=always {}")
    if not ($selected | is-empty) {
        nvim ...($selected | split row "\n")
    }
}

# Config shortcuts
alias v. = nvim .
alias nvimrc = nvim $"($nu.home-path | path join '.config/nvim')"

def nvimrcc --env [] {
  let nvim_path = $nu.home-path | path join '.config/nvim'
  cd $nvim_path
  nvim .
}

def nurc --env [] {
  let nu_path = $nu.home-path | path join '.config/nushell'
  cd $nu_path
  nvim .
}

# Tmux related
alias t = tmux
def ta --env [session_name: string] {
  tmux attach -t $session_name
}

# Git and related tools
# Lazytools
alias lgt = lazygit
alias lzd = lazydocker
alias lzn = lazynpm

def glog [] {
    let commit = (git log --oneline 
        | fzf --preview 'git show --color=always {+1}' 
        | split row " " 
        | first)

    if not ($commit | is-empty) {
        git show $commit
    }
}

# Package management
alias pcupdate = yay --noconfirm

# Remote connections
alias rpiadmin = ssh agunthe1@rpi.adrieng.ch
alias rpi = ssh github@rpi.adrieng.ch

# Rust
alias cr = cargo run
