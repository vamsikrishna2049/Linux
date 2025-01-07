# Create multiple users with their home directories, set a default password, and force them to change their password upon the first login (all while specifying their full names)

## Users name will be create in text file (users.txt)
user1, "John Doe"
user2, "Jane Smith"
user3, "Alice Johnson"

## Shell Script
```bash
#!/bin/bash

# Default password for all users
default_password="defaultpassword"

# Path to the users list file
users_file="users.txt"

# Check if users.txt exists
if [ ! -f "$users_file" ]; then
  echo "File $users_file not found!"
  exit 1
fi

# Read the list of users from the file and create them
while IFS=, read -r username fullname; do
  # Remove leading and trailing spaces
  username=$(echo $username | xargs)
  fullname=$(echo $fullname | xargs)

  # Check if the user already exists
  if id "$username" &>/dev/null; then
    echo "User $username already exists. Skipping user creation."
    
    # Optionally, update the full name (if needed)
    sudo chfn -f "$fullname" "$username"
    
    # Optionally, force the user to change the password again (if needed)
    sudo chage -d 0 "$username"
    
  else
    # Create the user with a home directory
    sudo useradd -m "$username"

    # Set the default password
    echo "$username:$default_password" | sudo chpasswd

    # Set the full name using chfn (change finger information)
    sudo chfn -f "$fullname" "$username"

    # Force the user to change the password on the first login
    sudo chage -d 0 "$username"

    echo "User $username with full name '$fullname' created with default password and forced to change on first login."
  fi
done < "$users_file"
```
