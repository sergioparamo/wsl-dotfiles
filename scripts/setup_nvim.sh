#!/usr/bin/env bash
set -e

echo "📝 Setting up Neovim..."

# Install Neovim and dependencies
sudo apt update
sudo apt install -y neovim git curl unzip fonts-firacode

# --- Install Packer plugin manager ---
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ -d "$PACKER_DIR" ]; then
    echo "🔄 Packer already installed, updating..."
    git -C "$PACKER_DIR" pull
else
    echo "📥 Installing Packer..."
    mkdir -p "$(dirname "$PACKER_DIR")"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
fi

# --- Copy init.lua ---
NVIM_CONFIG_DIR="$HOME/.config/nvim"
mkdir -p "$NVIM_CONFIG_DIR"

if [ -f "nvim/init.lua" ]; then
    cp nvim/init.lua "$NVIM_CONFIG_DIR/init.lua"
    echo "📄 init.lua copied to $NVIM_CONFIG_DIR"
else
    echo "⚠️ Warning: nvim/init.lua not found in current directory."
fi

# --- Fira Code font check ---
if ! fc-list | grep -i "FiraCode" &> /dev/null; then
    echo "📥 Installing Fira Code font..."
    sudo apt install -y fonts-firacode
else
    echo "✅ Fira Code font already installed."
fi

echo "✅ Neovim installed and configured!"