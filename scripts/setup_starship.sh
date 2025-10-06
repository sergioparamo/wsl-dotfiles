#!/usr/bin/env bash
set -e

echo "✨ Installing Starship prompt..."

if ! command -v starship &> /dev/null; then
    curl -fsSL https://starship.rs/install.sh | bash -s -- -y
fi

mkdir -p "$HOME/.config"
cp starship/starship.toml "$HOME/.config/starship.toml"

echo "✅ Starship installed and configured!"