export WEBKIT_DISABLE_DMABUF_RENDERER=1
export SDKMAN_DIR="$HOME/.sdkman"
export OHMYPOSH="$HOME/.config/oh-my-posh/"
export GEM_HOME="$(gem env user_gemhome)"
export JAVA_HOME="/home/agunthe1/.jdks/openjdk-22.0.1"
export GHIDRA_INSTALL_DIR=/home/agunthe1/ghidra/
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
export RANGER_LOAD_DEFAULT_RC=false
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export TMUXIFIER_LAYOUT_PATH=$HOME/.config/tmux/layouts/

export MANPAGER='nvim +Man!'
export MANWIDTH=999

export PATH=$HOME/go/bin:$HOME/bin:$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH="$PATH:$GEM_HOME/bin:$HOME/.config/tmux/plugins/tmuxifier/bin/"
export DEVKITPRO=/opt/devkitpro
export DEVKITARM=/opt/devkitpro/devkitARM
export DEVKITPPC=/opt/devkitpro/devkitPPC

export DOCKER_HOST=unix:///var/run/docker.sock

# cs50 stuff
export CC="clang"
export CFLAGS="-ferror-limit=1 -gdwarf-4 -ggdb3 -O0 -std=c11 -Wall -Werror -Wextra -Wno-gnu-folding-constant -Wno-sign-compare -Wno-unused-parameter -Wno-unused-variable -Wno-unused-but-set-variable -Wshadow"
export LDLIBS="-lcrypt -lcs50 -lm"
