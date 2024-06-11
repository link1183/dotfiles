export GEM_HOME="$(gem env user_gemhome)"
export PATH="$PATH:$GEM_HOME/bin:$HOME/bin"

# Added by Toolbox App
export PATH="$PATH:/home/agunthe1/.local/share/JetBrains/Toolbox/scripts"

export JAVA_HOME="/home/agunthe1/.jdks/openjdk-22.0.1"
export GHIDRA_INSTALL_DIR=/home/agunthe1/ghidra/
. "$HOME/.cargo/env"

export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/"
