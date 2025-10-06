#!/usr/bin/env bash
set -e

echo "✨ Installing Starship prompt..."

# Install Starship if not installed
if ! command -v starship &> /dev/null; then
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# Ensure config folder exists
mkdir -p "$HOME/.config"

# Copy starship.toml if it exists
if [ -f "./starship/starship.toml" ]; then
    cp ./starship/starship.toml "$HOME/.config/starship.toml"
    echo "📄 starship.toml copied to ~/.config/"
else
    echo "⚠️ Warning: ./starship/starship.toml not found"
fi

# Initialize Starship in Zsh
ZSHRC="$HOME/.zshrc"
touch "$ZSHRC"
if ! grep -q 'starship init zsh' "$ZSHRC"; then
    echo 'eval "$(starship init zsh)"' >> "$ZSHRC"
    echo "🔧 Starship initialized in $ZSHRC"
fi

echo "✅ Starship installed and configured!"