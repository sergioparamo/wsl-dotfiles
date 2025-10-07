#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "==> Updating Ubuntu packages..."
sudo apt update && sudo apt upgrade -y

echo "==> Installing basic tools..."
sudo apt install -y build-essential dkms curl software-properties-common apt-transport-https ca-certificates gnupg lsb-release

echo "==> Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
echo "Docker installed. Log out and log back in to apply docker group."

echo "==> Adding NVIDIA CUDA repository..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update

echo "==> Installing NVIDIA Container Toolkit..."
sudo apt install -y nvidia-docker2
sudo systemctl restart docker

echo "==> Installing CUDA for WSL2..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt update
sudo apt install -y cuda

echo "==> Setting up CUDA environment variables dynamically..."
# Detect the installed CUDA version
CUDA_PATH=$(ls -d /usr/local/cuda-* 2>/dev/null | sort -V | tail -n 1)

if [ -z "$CUDA_PATH" ]; then
    echo "CUDA installation not found!"
    exit 1
fi

echo "Detected CUDA path: $CUDA_PATH"

# Add CUDA to PATH and LD_LIBRARY_PATH if not already added
if ! grep -q "$CUDA_PATH/bin" ~/.bashrc; then
    echo "export PATH=$CUDA_PATH/bin:\$PATH" >> ~/.bashrc
    echo "export LD_LIBRARY_PATH=$CUDA_PATH/lib64:\$LD_LIBRARY_PATH" >> ~/.bashrc
fi

# Export for current session
export PATH=$CUDA_PATH/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH

echo "==> Verifying NVIDIA GPU and CUDA installation..."
nvidia-smi
nvcc --version

echo "==> Testing Docker GPU support..."
docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi

echo "==> Setup completed! You can now run GPU-enabled Docker containers."
echo "Remember to log out and log back in to use docker without sudo."
