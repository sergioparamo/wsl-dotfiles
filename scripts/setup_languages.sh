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

# --- Node.js via NVM ---
echo "==> Installing NVM v0.40.3 if not present..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# Load NVM for current session
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js 24.9.0 if not installed
if ! nvm ls | grep -q "v24.9.0"; then
    nvm install 24.9.0
fi
nvm alias default 24.9.0
echo "Node.js $(node -v) installed via nvm"

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