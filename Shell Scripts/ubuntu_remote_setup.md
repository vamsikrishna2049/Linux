Setup of a remote desktop environment on an Ubuntu system. It installs necessary software like XFCE4, XRDP, and Ubuntu Desktop to enable remote desktop access. 
Additionally, it creates a new user with the provided credentials, installs media and development tools (VLC, Microsoft Edge Beta, and Visual Studio Code), configures firewall rules, and installs NoMachine for remote access.

```bash
#!/bin/bash
set -e

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install XFCE4, xrdp and ubuntu desktop
sudo apt install -y xfce4 xrdp ubuntu-desktop
# Prompt for username and password
read -p "Enter username: " username
read -sp "Enter password: " password
echo

# Add the user
sudo useradd "$username"

# Set the password
echo "$username:$password" | sudo chpasswd

# Display the created user information
echo "User $username has been created with the password set."

# Install VLC
sudo snap install vlc

# Install Microsoft Edge Beta
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge-beta.list
sudo apt update
sudo apt install microsoft-edge-beta

# Install Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code

#TCP 4000 enable
sudo ufw status
sudo ufw enable
sudo ufw allow 4000/tcp
sudo ufw status

#Install nomachine
wget https://download.nomachine.com/download/8.5/Linux/nomachine_8.5.3_1_amd64.deb
apt install ./nomachine_8.5.3_1_amd64.deb
```
