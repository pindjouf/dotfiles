#!/usr/bin/env bash

set -e

# Function to print error messages
error() {
    echo "Error: $1" >&2
    exit 1
}

# Function to confirm actions
confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

# Main script
echo "Welcome to the dotfiles installer!"

# Check if git is installed
if ! command -v git &> /dev/null; then
    error "git is not installed. Please install git and try again."
fi

# Clone the repository
echo "Cloning the dotfiles repository..."
if ! git clone https://github.com/pindjouf/dotfiles.git /tmp/dotfiles; then
    error "Failed to clone the repository."
fi

# Check if the hyprlandd directory exists
if [ ! -d "/tmp/dotfiles/hyprlandd" ]; then
    rm -rf /tmp/dotfiles
    error "The hyprlandd directory does not exist in the cloned repository."
fi

# Confirm before copying files
if confirm "This will copy files to ~/.config. Any existing files will be overwritten. Continue?"; then
    # Create ~/.config if it doesn't exist
    mkdir -p ~/.config

    # Copy files
    echo "Copying dotfiles to ~/.config..."
    if ! cp -R /tmp/dotfiles/hyprlandd/* ~/.config/; then
        rm -rf /tmp/dotfiles
        error "Failed to copy files to ~/.config."
    fi

    # Remove the cloned repository
    echo "Cleaning up..."
    rm -rf /tmp/dotfiles

    echo "Dotfiles installation complete!"
else
    echo "Operation cancelled."
    rm -rf /tmp/dotfiles
fi
