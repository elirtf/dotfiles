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
	if [ -e "$target" ]; then
		if [ -L "$target" ]; then
			echo "$target is already a symlink, removing..."
			rm "$target"
		else
			echo "Backing up existing $target to ${target}.backup"
			mv "$target" "${target}.backup"
		fi
	fi
}

# Backup existing configs
echo "Checking for existing configurations..."
backup_if_exists "$HOME/.config/sway"
backup_if_exists "$HOME/.config/waybar"
backup_if_exists "$HOME/.config/starship.toml"
backup_if_exists "$HOME/.config/zsh"
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.zprofile"
backup_if_exists "$HOME/.bashrc"
backup_if_exists "$HOME/.bash_profile"

# Stow the packages
echo "Creating symlinks..."
if stow sway waybar zsh bash; then
	echo "Successfully created all symlinks!"
else
	echo "Stow failed. Trying with --adopt to handle conflicts..."
	echo "This will overwrite your dotfiles with any existing files."
	read -p "Continue? (y/N): " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		stow --adopt sway waybar zsh bash starship zsh-config
		echo "Symlinks created with --adopt"
	else
		echo "Installation cancelled"
		exit 1
	fi
fi
