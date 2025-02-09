#!/bin/bash

# Update the package index
echo "Updating package index..."
sudo apt-get update

# Install necessary dependencies: ca-certificates and curl
echo "Installing ca-certificates and curl..."
sudo apt-get install -y ca-certificates curl

# Create the directory for Docker GPG key
echo "Creating directory for Docker's GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's official GPG key and save it
echo "Downloading Docker's official GPG key..."
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Set proper permissions for the GPG key
echo "Setting permissions for the Docker GPG key..."
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker's official repository to apt sources
echo "Adding Docker's repository to the sources list..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again after adding Docker repository
echo "Updating package index again to include Docker repository..."
sudo apt-get update

# Optional: Confirm that Docker repository is added
echo "Checking if Docker repository is correctly added..."
cat /etc/apt/sources.list.d/docker.list

echo "Docker repository has been successfully added."

# Docker installation (install Docker Engine)
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker --version

echo "Docker installation is complete."

# Docker-compose installation 
echo "Installing Docker compose..."
sudo apt-get install -y docker-compose

# Verify docker-compose installation
echo "Verifying docker-compose installation..."
sudo docker-compose --version

echo "docker-compose installation is complete."
