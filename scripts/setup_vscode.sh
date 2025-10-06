#!/usr/bin/env bash
set -e

echo "🖥️ Configuring VS Code..."

# Install VS Code if not present
if ! command -v code &> /dev/null; then
    TMP_DEB=$(mktemp)
    wget -qO "$TMP_DEB" https://update.code.visualstudio.com/latest/linux-deb-x64/stable
    sudo dpkg -i "$TMP_DEB" || sudo apt --fix-broken install -y
    rm "$TMP_DEB"
fi

# Create VS Code user settings folder
VSCODE_USER_DIR="$HOME/.config/Code/User"
mkdir -p "$VSCODE_USER_DIR"

# Write settings.json
cat > "$VSCODE_USER_DIR/settings.json" << 'EOF'
{
  "terminal.integrated.shell.linux": "/usr/bin/zsh",
  "editor.fontFamily": "Fira Code",
  "editor.fontLigatures": true,
  "workbench.colorTheme": "Dracula",
  "files.autoSave": "onFocusChange"
}
EOF
echo "📄 VS Code settings.json configured"

# Install recommended extensions
extensions=(
  "eamodio.gitlens"
  "esbenp.prettier-vscode"
  "dbaeumer.vscode-eslint"
  "dracula-theme.theme-dracula"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
  "ms-vscode-remote.remote-ssh"
  "ms-vscode-remote.remote-ssh-edit"
  "pkief.material-icon-theme"
)
for ext in "${extensions[@]}"; do
    code --install-extension "$ext" || true
done
echo "✅ VS Code extensions installed"

echo "🎉 VS Code setup complete!"