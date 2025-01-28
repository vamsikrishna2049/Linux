#!/bin/bash

# Function to uninstall Git
uninstall_git() {
    echo "Uninstalling Git..."
    if [[ -f /etc/debian_version ]]; then
        sudo apt remove --purge git -y
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum remove git -y
    fi
}

# Function to uninstall Maven
uninstall_maven() {
    echo "Uninstalling Maven..."
    if [[ -f /etc/debian_version ]]; then
        sudo apt remove --purge maven -y
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum remove maven -y
    fi
}

# Function to uninstall Jenkins
uninstall_jenkins() {
    echo "Uninstalling Jenkins..."
    if [[ -f /etc/debian_version ]]; then
        sudo apt remove --purge jenkins -y
        sudo rm /etc/apt/sources.list.d/jenkins.list
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum remove jenkins -y
        sudo rm /etc/yum.repos.d/jenkins.repo
    fi
}

# Function to uninstall Terraform
uninstall_terraform() {
    echo "Uninstalling Terraform..."
    if [[ -f /etc/debian_version ]]; then
        sudo rm /usr/local/bin/terraform
        sudo rm terraform_*.zip
    elif [[ -f /etc/redhat-release ]]; then
        sudo rm /usr/local/bin/terraform
        sudo rm terraform_*.zip
    fi
}

# Function to uninstall Docker
uninstall_docker() {
    echo "Uninstalling Docker..."
    if [[ -f /etc/debian_version ]]; then
        sudo apt remove --purge docker-ce docker-ce-cli containerd.io -y
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum remove docker-ce docker-ce-cli containerd.io -y
    fi
    # Stop and disable Docker service
    sudo systemctl stop docker
    sudo systemctl disable docker
}

# Function to uninstall kubectl
uninstall_kubectl() {
    echo "Uninstalling kubectl..."
    sudo rm /usr/local/bin/kubectl
}

# Function to uninstall Kops
uninstall_kops() {
    echo "Uninstalling Kops..."
    sudo rm /usr/local/bin/kops
}

# Function to remove residual configuration files
remove_residual_files() {
    echo "Cleaning up residual files and configurations..."
    # For Debian-based systems, also remove any configuration files
    if [[ -f /etc/debian_version ]]; then
        sudo apt autoremove --purge -y
        sudo apt clean
    elif [[ -f /etc/redhat-release ]]; then
        sudo yum autoremove -y
    fi
}

# Main script execution
uninstall_git
uninstall_maven
uninstall_jenkins
uninstall_terraform
uninstall_docker
uninstall_kubectl
uninstall_kops
remove_residual_files

echo "Uninstallation completed successfully!"
