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

# An issue with the current Docker 28.0.0 requires a different set of kernel modules to be enabled.
# The JetPack 6.2 release of Jetson doesn't support these. So we downgrade
sudo apt-get install -y docker-ce=5:27.5.1-1~ubuntu.22.04~jammy --allow-downgrades
sudo apt-get install -y docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy --allow-downgrades
# The we mark them so they do not get upgraded with apt upgrade
sudo apt-mark hold docker-ce=5:27.5.1-1~ubuntu.22.04~jammy
sudo apt-mark hold docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy

rm docker_install.sh

# Enable and start the Docker service.
sudo systemctl --now enable docker

# Configure NVIDIA Container Toolkit.
sudo nvidia-ctk runtime configure --runtime=docker

echo "NVIDIA Docker installation complete."
exit 0
