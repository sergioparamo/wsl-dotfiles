#!/usr/bin/env bash
# Install and configure latest stable Python, Node.js, Java
set -e

echo "==> Installing build dependencies for Python..."
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev

# --- Python via pyenv ---
echo "==> Installing Python 3.13.7 via pyenv..."
if ! command -v pyenv &> /dev/null; then
    curl https://pyenv.run | bash
fi

# Initialize pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Install Python 3.13.7 if not installed
if ! pyenv versions | grep -q "3.13.7"; then
    pyenv install 3.13.7
fi
pyenv global 3.13.7
echo "Python $(python --version) installed via pyenv"

# Upgrade pip
pip install --upgrade pip setuptools wheel

# --- Node.js via NVM ---
echo "==> Installing NVM v0.40.3..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js 24.9.0
if ! nvm ls | grep -q "v24.9.0"; then
    nvm install 24.9.0
fi
nvm alias default 24.9.0
echo "Node.js $(node -v) installed via nvm"

# --- Java via SDKMAN ---
echo "==> Installing Java JDK 25 via SDKMAN..."
if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash
fi

# Load SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Install JDK 25 if not installed
if ! sdk list java | grep -q "25"; then
    sdk install java 25-open
fi
sdk default java 25-open
echo "Java $(java -version | head -n 1) installed via SDKMAN"
echo "==> All languages installed and configured successfully!"