#!/bin/bash

# Dotfiles Installation Script
set -e

echo "Setting up dotfiles..."

# Check if stow is installed
if ! command -v stow &> /dev/null; then
	echo "Stow is not installed. Please install it first:"
	echo "	Arch/Manjaro: 	sudo pacman -S stow"
	echo "	Ubuntu/Debian: 	sudo apt install stow"
	echo "	Fedora: 	sudo dnf install stow"
	echo "	Void:		sudo xbps-install stow"
	exit 1
fi

# Get the directory of script location
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

echo "Dotfiles directory: $DOTFILES_DIR"

# Check for existing configs & backup if needed
backup_if_exists() {
	local target="$1"
	if [ -e "$target" ] && [ ! -L "$target" ]; then
		echo "Backing up existing $target to ${target}.backup"
		mv "$target" "${target}.backup"
	fi
}

# Backup existing configs
backup_if_exists "$HOME/.config/sway"
backup_if_exists "$HOME/.config/waybar"

# Stow the packages
echo "Creating symlinks..."
stow sway waybar

echo "Dotfiles installation complete!"
