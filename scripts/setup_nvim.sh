#!/usr/bin/env bash
set -e

echo "📝 Setting up Neovim..."

sudo apt install -y neovim git curl unzip

# Install Packer plugin manager
mkdir -p ~/.local/share/nvim/site/pack/packer/start
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Copy init.lua
mkdir -p "$HOME/nvim"
cp nvim/init.lua "$HOME/nvim/init.lua"

# Install Fira Code font
if ! fc-list | grep -i "FiraCode" &> /dev/null; then
    sudo apt install -y fonts-firacode
fi

echo "✅ Neovim installed and configured!"