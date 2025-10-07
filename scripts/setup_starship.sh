#!/usr/bin/env bash
set -e

echo "✨ Installing Starship prompt..."

# -----------------------------
# Install Starship if not installed
# -----------------------------
if ! command -v starship &> /dev/null; then
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

# Ensure config folder exists
mkdir -p "$HOME/.config"

# Copy starship.toml if it exists
if [ -f "./starship/starship.toml" ]; then
    cp ./starship/starship.toml "$HOME/.config/starship.toml"
    echo "📄 starship.toml copied to ~/.config/"

    # Remove invalid 'docker' block to avoid warnings
    if grep -q "^\[docker\]" "$HOME/.config/starship.toml"; then
        echo "🧹 Removing invalid [docker] block from starship.toml"
        # Remove lines from [docker] to next [block] or EOF
        awk '/^\[docker\]/{flag=1;next}/^\[/{flag=0}flag==0{print}' "$HOME/.config/starship.toml" > "$HOME/.config/starship.toml.tmp"
        mv "$HOME/.config/starship.toml.tmp" "$HOME/.config/starship.toml"
    fi
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

# -----------------------------
# Install zoxide if not installed
# -----------------------------
if ! command -v zoxide &> /dev/null; then
    echo "🐙 Installing zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# -----------------------------
# Ensure ~/.local/bin is in PATH for zoxide
# -----------------------------
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$ZSHRC"
    export PATH="$HOME/.local/bin:$PATH"
    echo "🔧 Added ~/.local/bin to PATH"
fi

# Initialize zoxide in Zsh and silence warnings from other shells (since fish is called by default)
if ! grep -q 'zoxide init zsh' "$ZSHRC"; then
    echo 'eval "$(zoxide init zsh 2>/dev/null)"' >> "$ZSHRC"
    echo "🔧 zoxide initialized in $ZSHRC"
fi
