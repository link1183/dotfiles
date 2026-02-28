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
alias up='yay -Syu'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

open() (
  xdg-open "$@" >/dev/null 2>&1 &
)

# Write iso file to sd card
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

  sudo dd bs=4M status=progress oflag=sync if="$iso" of="$drive"
  sudo eject "$drive"
}

# Format an entire drive for a single partition using exFAT
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

# Transcode a video to a good-balance 1080p that's great for sharing online
transcode-video-1080p() {
  ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy "${1%.*}-1080p.mp4"
}

# Transcode a video to a good-balance 4K that's great for sharing online
transcode-video-4K() {
  ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k "${1%.*}-optimized.mp4"
}

# Transcode any image to JPG image that's great for shrinking wallpapers
img2jpg() {
  img="$1"
  shift

  magick "$img" "$@" -quality 95 -strip "${img%.*}-converted.jpg"
}

# Transcode any image to a small JPG (max 1080px wide) that's great for sharing online
img2jpg-small() {
  img="$1"
  shift

  magick "$img" "$@" -resize 1080x\> -quality 95 -strip "${img%.*}-small.jpg"
}

# Transcode any image to a medium JPG (max 1800px wide) that's great for sharing online
img2jpg-medium() {
  img="$1"
  shift

  magick "$img" "$@" -resize 1800x\> -quality 95 -strip "${img%.*}-medium.jpg"
}

# Transcode any image to compressed-but-lossless PNG
img2png() {
  img="$1"
  shift

  magick "$img" "$@" -strip -define png:compression-filter=5 \
    -define png:compression-level=9 \
    -define png:compression-strategy=1 \
    -define png:exclude-chunk=all \
    "${img%.*}-optimized.png"
}
