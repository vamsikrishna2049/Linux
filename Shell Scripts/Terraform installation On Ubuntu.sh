#!/bin/bash

# Update the package list and install required dependencies
echo "Updating package list and installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y gnupg software-properties-common

# Add HashiCorp's GPG key to verify package integrity
echo "Adding HashiCorp GPG key..."
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the GPG key fingerprint
echo "Verifying the GPG key fingerprint..."
gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint

# Add the HashiCorp repository to the apt sources list
echo "Adding HashiCorp repository to apt sources list..."
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update the package list again after adding the repository
echo "Updating package list after adding the repository..."
sudo apt-get update -y

# Install Terraform
echo "Installing Terraform..."
sudo apt-get install terraform -y

echo "Terraform installation completed on Ubuntu!"