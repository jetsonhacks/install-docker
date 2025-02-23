#!/bin/bash
# Script Name: downgrade_docker.sh
# Description: Downgrades Docker to JetPack 6.2-compatible versions
set -e

# Inform the user about the script's purpose and ask for confirmation
echo "This script will:"
echo "1. Update package lists"
echo "2. Downgrade Docker to specific versions (5:27.5.1 and related components) compatible with JetPack 6.2."
echo "3. Mark the downgraded Docker packages as held to prevent automatic upgrades."
echo "4. Reload the Docker service to apply changes."
echo
read -p "Do you want to continue? (y/N): " response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  echo "Aborting script execution."
  exit 1
fi

sudo apt update

# Downgrade Docker to specific versions (JetPack 6.2 compatibility)
sudo apt-get install -y --allow-downgrades \
  docker-ce=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-compose-plugin=2.32.4-1~ubuntu.22.04~jammy \
  docker-buildx-plugin=0.20.0-1~ubuntu.22.04~jammy \
  docker-ce-rootless-extras=5:27.5.1-1~ubuntu.22.04~jammy

# Mark packages as held to prevent upgrades
sudo apt-mark hold \
  docker-ce=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-ce-cli=5:27.5.1-1~ubuntu.22.04~jammy \
  docker-compose-plugin=2.32.4-1~ubuntu.22.04~jammy \
  docker-buildx-plugin=0.20.0-1~ubuntu.22.04~jammy \
  docker-ce-rootless-extras=5:27.5.1-1~ubuntu.22.04~jammy

# Reload Docker service to apply changes
sudo systemctl reload docker

echo "Docker downgrade and NVIDIA configuration complete."
exit 0
