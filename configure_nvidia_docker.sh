#!/bin/bash

# Script Name: configure_nvidia_docker.sh

# Description: Configures NVIDIA Docker for default runtime and user access.

# Exit immediately if a command exits with a non-zero status.
set -e

# Add the current user to the docker group (important for non-root Docker usage).
sudo usermod -aG docker $USER

# Install jq for JSON manipulation.
sudo apt install -y jq

# Configure Docker daemon to use nvidia as the default runtime.
sudo jq '. + {"default-runtime": "nvidia"}' <<< "$(cat /etc/docker/daemon.json)" | \
    sudo tee /etc/docker/daemon.json
    
# Reload the Docker daemon and restart Docker to apply the default runtime configuration.
sudo systemctl daemon-reload && sudo systemctl restart docker

echo "NVIDIA Docker configuration complete."
echo "Log out and back in for the group changes to take effect."
exit 0
