# --------------------------------------------------
# Prompt
# --------------------------------------------------
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
  export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
fi

# --------------------------------------------------
# Oh My Zsh
# --------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
  fzf-tab
  sudo
  zsh-completions
)

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------
# Tools
# --------------------------------------------------

# fzf
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"

# direnv
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# --------------------------------------------------
# Aliases
# --------------------------------------------------

alias c='clear'
alias la='eza -lha --icons=auto --sort=name --group-directories-first'
alias lt='eza --icons=auto --tree'
alias v='nvim'
alias v.='nvim .'
alias e='exit'
alias lg='lazygit'
alias lz='lazydocker'
alias cat='bat'
alias up='yay -Syu'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'
alias rmrf='rm -rf'
alias y='yazi'
alias zshrc='nvim ~/.zshrc'
alias nvimrc='nvim ~/.config/nvim'

# --------------------------------------------------
# Functions
# --------------------------------------------------

compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

open() { xdg-open "$@" >/dev/null 2>&1 & }

df() { command -v duf &>/dev/null && duf "$@" || command df "$@"; }

# ISO to SD
iso2sd() {
  if (( $# < 1 )); then
    echo "Usage: iso2sd <input_file> [output_device]"
    echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
    return 1
  fi

  local iso="$1"
  local drive="$2"

  if [[ -z $drive ]]; then
    local available_sds=$(lsblk -dpno NAME | grep -E '/dev/sd')

    if [[ -z $available_sds ]]; then
      echo "No SD drives found and no drive specified"
      return 1
    fi

    drive=$(omarchy-drive-select "$available_sds")

    if [[ -z $drive ]]; then
      echo "No drive selected"
      return 1
    fi
  fi

  lsblk "$drive"
  read -rp "Write to $drive? This will destroy data. (yes/no): " confirm
  [[ $confirm == yes ]] || return 1

  sudo dd bs=4M status=progress oflag=sync if="$iso" of="$drive"
  sudo eject "$drive"
}

format-drive() {
  if (( $# != 2 )); then
    echo "Usage: format-drive <device> <name>"
    echo "Example: format-drive /dev/sda 'My Stuff'"
    echo -e "\nAvailable drives:"
    lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
  else
    echo "WARNING: This will completely erase all data on $1 and label it '$2'."
    read -rp "Are you sure you want to continue? (y/N): " confirm

    if [[ $confirm =~ ^[Yy]$ ]]; then
      sudo wipefs -a "$1"
      sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
      sudo parted -s "$1" mklabel gpt
      sudo parted -s "$1" mkpart primary 1MiB 100%
      sudo parted -s "$1" set 1 msftdata on

      partition="$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
      sudo partprobe "$1" || true
      sudo udevadm settle || true

      sudo mkfs.exfat -n "$2" "$partition"

      echo "Drive $1 formatted as exFAT and labeled '$2'."
    fi
  fi
}

transcode-video-1080p() {
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}

transcode-video-4K() {
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}

img2jpg() {
  magick "$1" -quality 95 -strip "${1%.*}-converted.jpg"
}

img2jpg-small() {
  magick "$1" -resize 1080x\> -quality 95 -strip "${1%.*}-small.jpg"
}

img2jpg-medium() {
  magick "$1" -resize 1800x\> -quality 95 -strip "${1%.*}-medium.jpg"
}

img2png() {
  magick "$1" -strip \
    -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${1%.*}-optimized.png"
}
