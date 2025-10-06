#!/usr/bin/env bash
set -e

echo "🔄 Updating dotfiles and tools..."

cd "$HOME/wsl-dotfiles"
git pull origin main

echo "Updating Oh My Zsh..."
omz update

echo "Updating Neovim plugins..."
nvim --headless +PackerSync +qall

echo "Updating APT packages..."
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo "Updating VS Code extensions..."
code --list-extensions | xargs -L 1 echo | xargs -L 1 code --install-extension

echo "Cleaning Docker..."
docker system prune -

echo "✅ Update complete!"