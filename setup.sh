#!/bin/bash

set -e # Exit on any error

# Variables
DOTFILES_REPO="https://github.com/link1183/dotfiles"
DOTFILES_DIR="$HOME/projects/github/dotfiles"
YAY_PACKAGES_FILE="./yay-packages.txt"
TPM_REPO="https://github.com/tmux-plugins/tpm"
TPM_DIR="$HOME/.config/tmux/plugins/tpm"

# Ensure the script is running as a non-root user with sudo privileges
if [ "$(id -u)" = "0" ]; then
	echo "Please run this script as a non-root user with sudo privileges."
	exit 1
fi

# Install Hyprland and dependencies
echo "Installing Hyprland and dependencies..."
sudo pacman -Syu --noconfirm hyprland

# Install yay
echo "Installing yay..."
if ! command -v yay &>/dev/null; then
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
	cd -
	rm -rf /tmp/yay
else
	echo "yay is already installed."
fi

# Install packages from yay-packages.txt
if [ -f "$YAY_PACKAGES_FILE" ]; then
	echo "Installing packages from $YAY_PACKAGES_FILE..."
	yay -S --needed --noconfirm - <"$YAY_PACKAGES_FILE"
else
	echo "Package file $YAY_PACKAGES_FILE not found. Skipping package installation."
fi

# Clone dotfiles repository and run stowinit
echo "Cloning dotfiles repository..."
mkdir -p "$(dirname "$DOTFILES_DIR")"
if [ ! -d "$DOTFILES_DIR" ]; then
	git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
	echo "Dotfiles directory already exists."
fi

echo "Running stowinit..."
cd "$DOTFILES_DIR"
if [ -x "./stowinit" ]; then
	./stowinit
else
	echo "stowinit script not found or not executable in $DOTFILES_DIR."
fi
cd -

# Clone TPM
echo "Cloning TPM..."
if [ ! -d "$TPM_DIR" ]; then
	git clone "$TPM_REPO" "$TPM_DIR"
else
	echo "TPM already installed at $TPM_DIR."
fi

# Install Rust
echo "Installing Rust..."
if ! command -v rustup &>/dev/null; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
	echo "Rust is already installed."
fi

echo "Setup script completed successfully!"
