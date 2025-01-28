## Function to check for package version details

```bash
#!/bin/bash

# Function to check for package version details
check_package_version() {
    PACKAGE_NAME=$1
    # Get the installed version of the package
    INSTALLED_VERSION=$(dpkg-query -W -f='${Version}' $PACKAGE_NAME 2>/dev/null)

    # Check if the package is installed
    if [ -z "$INSTALLED_VERSION" ]; then
        echo "$PACKAGE_NAME is not installed."
        return
    fi

    # Get the available version of the package from the repository
    AVAILABLE_VERSION=$(apt list --upgradable 2>/dev/null | grep "$PACKAGE_NAME" | awk -F' ' '{print $2}')

    if [ -z "$AVAILABLE_VERSION" ]; then
        echo "$PACKAGE_NAME is up to date with version $INSTALLED_VERSION."
    else
        echo "$PACKAGE_NAME installed version: $INSTALLED_VERSION"
        echo "$PACKAGE_NAME available version: $AVAILABLE_VERSION"

        # Ask user whether to update or hold the package
        read -p "Do you want to update $PACKAGE_NAME to the latest version (Y/N)? " choice
        if [[ "$choice" == "Y" || "$choice" == "y" ]]; then
            sudo apt install --only-upgrade $PACKAGE_NAME
            echo "$PACKAGE_NAME has been upgraded to version $AVAILABLE_VERSION."
        else
            read -p "Do you want to hold the $PACKAGE_NAME at version $INSTALLED_VERSION to prevent future upgrades (Y/N)? " hold_choice
            if [[ "$hold_choice" == "Y" || "$hold_choice" == "y" ]]; then
                sudo apt-mark hold $PACKAGE_NAME
                echo "$PACKAGE_NAME has been held at version $INSTALLED_VERSION."
            else
                echo "$PACKAGE_NAME will remain as is."
            fi
        fi
    fi
}

# Main script logic
echo "Checking installed packages and their available updates..."
# List of all installed packages
INSTALLED_PACKAGES=$(dpkg-query -W -f='${Package}\n')

# Loop through the list of installed packages and check each one
for PACKAGE in $INSTALLED_PACKAGES; do
    check_package_version $PACKAGE
done

echo "Script execution completed."
```