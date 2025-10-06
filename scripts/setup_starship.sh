#!/usr/bin/env bash
set -e

echo "✨ Installing Starship prompt..."

# Install Starship if not installed
if ! command -v starship &> /dev/null; then
    # Use sh instead of bash to avoid warnings
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# Ensure config folder exists
mkdir -p "$HOME/.config"

# Copy starship.toml if it exists
if [ -f "./starship/starship.toml" ]; then
    cp ./starship/starship.toml "$HOME/.config/starship.toml"
else
    echo "⚠️ Warning: starship.toml not found in ./starship/"
fi

# Initialize Starship in Zsh if not already present
if ! grep -q 'starship init zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

echo "✅ Starship installed and configured!"