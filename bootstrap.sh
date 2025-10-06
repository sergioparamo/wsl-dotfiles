#!/usr/bin/env bash
set -e

echo "🚀 Starting WSL2 development environment bootstrap..."

# Check essentials
ESSENTIALS=(git curl wget zsh sudo)
for cmd in "${ESSENTIALS[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        echo "⚡ Installing $cmd..."
        sudo apt update && sudo apt install -y $cmd
    else
        echo "✅ $cmd already installed"
    fi
done

# Clone repository if not exists
DOTFILES_DIR="$HOME/wsl-dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📥 Cloning dotfiles repository..."
    git clone https://github.com/sergioparamo/wsl-dotfiles.git "$DOTFILES_DIR"
else
    echo "📂 Dotfiles repository already exists"
fi

# Run main install script
echo "⚙️ Running main install script..."
bash "$DOTFILES_DIR/install.sh"

echo "✅ Bootstrap complete!"