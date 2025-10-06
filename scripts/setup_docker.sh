#!/usr/bin/env bash
set -e

echo "🐳 Installing Docker CLI and Docker Compose..."

sudo apt install -y \
    ca-certificates curl gnupg lsb-release

if ! command -v docker &> /dev/null; then
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

# Add user to docker group
sudo usermod -aG docker $USER

echo "✅ Docker installed and configured!"