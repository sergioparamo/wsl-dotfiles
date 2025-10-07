#!/usr/bin/env bash
set -e

echo "🔧 Running main installation..."

# Ensure scripts are executable
chmod +x *.sh scripts/*.sh

# Run modular setup scripts
for script in scripts/*.sh; do
    echo "==> Executing $script..."
    bash "$script"
done

echo "✅ WSL2 development environment installed successfully!"
echo "🔄 Please restart your terminal to apply all changes."
