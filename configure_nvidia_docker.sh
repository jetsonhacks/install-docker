#!/bin/bash

# Script Name: configure_nvidia_docker.sh

# Description: Configures NVIDIA Docker for default runtime and user access.

# Exit immediately if a command exits with a non-zero status.
set -e

# Add the current user to the docker group (important for non-root Docker usage).
sudo usermod -aG docker $USER

# Apply group changes for the current user (you might need to log out and back in, or run 'newgrp docker').
newgrp docker

# Install jq for JSON manipulation.
sudo apt install -y jq

# Configure Docker daemon to use nvidia as the default runtime.
sudo jq '. + {"default-runtime": "nvidia"}' /etc/docker/daemon.json | \
  sudo tee /etc/docker/daemon.json.tmp && \
  sudo mv /etc/docker/daemon.json.tmp /etc/docker/daemon.json

# Reload the Docker daemon and restart Docker to apply the default runtime configuration.
sudo systemctl daemon-reload && sudo systemctl restart docker

echo "NVIDIA Docker configuration complete."
echo "You may need to log out and back in for the group changes to take effect."
exit 0
