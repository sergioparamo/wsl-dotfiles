#!/usr/bin/env bash
# Install and configure latest stable Python, Node.js, Java
set -e

echo "==> Updating system and installing build dependencies..."
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev unzip zip git

# --- Python via pyenv ---
echo "==> Installing pyenv if not present..."
if [ ! -d "$HOME/.pyenv" ]; then
    curl https://pyenv.run | bash
fi

# Add pyenv to shell startup files for future sessions
if ! grep -q 'pyenv init' "$HOME/.bashrc"; then
    cat >> "$HOME/.bashrc" << 'EOF'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
fi

# Load pyenv for current session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

echo "==> Installing Python 3.13.7 via pyenv..."
if ! pyenv versions --bare | grep -q "^3.13.7$"; then
    pyenv install 3.13.7
fi
pyenv global 3.13.7
echo "Python $(python --version) installed via pyenv"

# Upgrade pip
pip install --upgrade pip setuptools wheel

# --- Node.js and npm installation (latest LTS via NodeSource) ---
echo "==> Installing Node.js (LTS) and npm..."

# Update system
sudo apt-get update -y

# Add NodeSource official repository for Node 22.x (LTS)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -

# Install Node.js and npm
sudo apt install -y nodejs npm

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Verify installation
echo "==> Node.js $(node -v), npm $(npm -v) and nvm $(nvm -v) installed successfully"

# --- Java via SDKMAN ---
echo "==> Installing SDKMAN if not present..."
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
fi

# Load SDKMAN for current session
if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
else
    echo "SDKMAN initialization script not found!"
    exit 1
fi

# Install JDK 25 if not installed
if ! sdk current java | grep -q "25"; then
    sdk install java 25-open
fi
sdk default java 25-open
echo "Java $(java -version | head -n 1) installed via SDKMAN"

echo "==> All languages installed and configured successfully!"
