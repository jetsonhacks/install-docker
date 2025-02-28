#!/bin/bash
# This undoes downgrade_docker.sh
# Unmark packages from being held to allow for upgrades
sudo apt-mark unhold \
  docker-ce=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-compose-plugin=2.32.4-1~ubuntu.22.04~jammy \
  docker-buildx-plugin=0.20.0-1~ubuntu.22.04~jammy \
  docker-ce-rootless-extras=5:27.5.1-1~ubuntu.22.04~jammy

# Update package list and upgrade the unheld packages
sudo apt update
sudo apt upgrade -y docker-ce docker-ce-cli docker-compose-plugin docker-buildx-plugin docker-ce-rootless-extras

# Check if Docker service is running and reload it if it is
if systemctl is-active --quiet docker; then
    echo "Docker service is running. Reloading..."
    sudo systemctl reload docker
    echo "Docker service reloaded."
else
    echo "Docker service is not running. No reload needed."
fi
