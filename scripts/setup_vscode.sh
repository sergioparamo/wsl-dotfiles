#!/usr/bin/env bash
set -e

echo "🖥️ Configuring VS Code..."

# Install VS Code (if not present)
if ! command -v code &> /dev/null; then
    wget -qO- https://update.code.visualstudio.com/latest/linux-deb-x64/stable | sudo dpkg -i /dev/stdin || sudo apt --fix-broken install -y
fi

mkdir -p "$HOME/.config/Code/User"

cat > "$HOME/.config/Code/User/settings.json" << 'EOF'
{
  "terminal.integrated.shell.linux": "/usr/bin/zsh",
  "editor.fontFamily": "Fira Code",
  "editor.fontLigatures": true,
  "workbench.colorTheme": "Dracula",
  "files.autoSave": "onFocusChange"
}
EOF

# Recommended extensions
extensions=(
  "eamodio.gitlens"
  "esbenp.prettier-vscode"
  "dbaeumer.vscode-eslint"
  "dracula-theme.theme-dracula"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-containers"
  "ms-vscode-remote.remote-ssh"
  "ms-vscode-remote.remote-ssh-edit"
    
pkief.material-icon-theme
)
for ext in "${extensions[@]}"; do
    code --install-extension $ext || true
done

echo "✅ VS Code configured!"