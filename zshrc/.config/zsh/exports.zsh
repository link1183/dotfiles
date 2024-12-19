
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Core editor and browser settings
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox

# Man pages optimization
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# System configurations
(( $+commands[webkit] )) && export WEBKIT_DISABLE_DMABUF_RENDERER=1

# Development tools
function setup_dev_tools() {
    local paths=()
    [[ -d "$HOME/flutter/flutter/bin" ]] && paths+=("$HOME/flutter/flutter/bin")

    # Go
    [[ -d "$HOME/go/bin" ]] && paths+=("$HOME/go/bin")

    # Linuxbrew
    [[ -d "/home/linuxbrew/.linuxbrew/bin" ]] && paths+=("/home/linuxbrew/.linuxbrew/bin")

    # Ruby Gems
    if (( $+commands[gem] )); then
        export GEM_HOME="$(gem env user_gemhome)"
        [[ -d "$GEM_HOME/bin" ]] && paths+=("$GEM_HOME/bin")
    fi

    # Java
    [[ -d "$HOME/.jdks/openjdk-22.0.1" ]] && export JAVA_HOME="$HOME/.jdks/openjdk-22.0.1"

    # Rust
    if [[ -d "$HOME/.rustup" ]]; then
        export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
    fi

    # DevkitPro toolchains
    if [[ -d "/opt/devkitpro" ]]; then
        export DEVKITPRO=/opt/devkitpro
        export DEVKITARM=/opt/devkitpro/devkitARM
        export DEVKITPPC=/opt/devkitpro/devkitPPC
    fi

    # Add all valid paths
    for path_entry in "${paths[@]}"; do
        [[ -d "$path_entry" ]] && PATH="$PATH:$path_entry"
    done
}
setup_dev_tools
unfunction setup_dev_tools  # Clean up after use

# Tool-specific configurations
# Docker
[[ -S "/var/run/docker.sock" ]] && export DOCKER_HOST=unix:///var/run/docker.sock

# Ghidra
[[ -d "$HOME/ghidra" ]] && export GHIDRA_INSTALL_DIR="$HOME/ghidra/"

# Oh My Posh
[[ -d "$HOME/.config/oh-my-posh" ]] && export OHMYPOSH="$HOME/.config/oh-my-posh/"

# FZF theme (Catppuccin Macchiato)
export FZF_DEFAULT_OPTS="\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Ranger
export RANGER_LOAD_DEFAULT_RC=false

# CS50 development settings
if (( $+commands[clang] )); then
    export CC="clang"
    export CFLAGS="-ferror-limit=1 -gdwarf-4 -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra \
-Wno-gnu-folding-constant -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable \
-Wno-unused-but-set-variable -Wshadow"
    export LDLIBS="-lcrypt -lcs50 -lm"
fi
