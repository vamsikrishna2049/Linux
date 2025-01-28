#!/bin/bash

if command -v aws &>/dev/null; then
    echo "AWS CLI is not installed"

else
    echo "AWS CLI is not installed. Installing now..."

    # Download and install AWS CLI version 2
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

    # Unzip the downloaded file
    unzip awscliv2.zip

    # Run the installer
    sudo ./aws/install

    # Clean up the installation files
    rm -rf awscliv2.zip aws

    echo "AWS CLI installation completed."
fi

AWS CLI