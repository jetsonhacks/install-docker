#!/bin/bash

# Script Name: install_nvidia_docker.sh

# Description: Installs NVIDIA Container Toolkit and Docker for GPU-accelerated containerization.

# Exit immediately if a command exits with a non-zero status.
set -e

# Update package lists.
sudo apt update

# Install the NVIDIA Container Toolkit.
sudo apt install -y nvidia-container

sudo apt update

# Download the Docker installation script.
wget https://get.docker.com -O docker_install.sh

# Check if the Docker installation script was downloaded successfully and is not empty.
if [ ! -s docker_install.sh ]; then
  echo "ERROR: Docker installation script download failed or file is empty."
  rm -f docker_install.sh  # Clean up any partial download.
  exit 1  # Exit with an error code.
fi

# Make the Docker installation script executable.
chmod +x docker_install.sh

# Install Docker.
sudo ./docker_install.sh

rm docker_install.sh

# Enable and start the Docker service.
sudo systemctl --now enable docker

# Configure NVIDIA Container Toolkit.
sudo nvidia-ctk runtime configure --runtime=docker

echo "NVIDIA Docker installation complete."
exit 0
