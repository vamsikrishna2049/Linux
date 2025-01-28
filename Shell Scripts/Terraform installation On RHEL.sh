#!/bin/bash

# Install yum-utils to manage repositories
echo "Installing yum-utils..."
sudo yum install -y yum-utils

# Add HashiCorp's repo to the system
echo "Adding HashiCorp repository..."
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# Install Terraform
echo "Installing Terraform..."
sudo yum -y install terraform

# Verify the Terraform installation
echo "Verifying Terraform installation..."
terraform -v

echo "Terraform installation completed on RHEL!"
