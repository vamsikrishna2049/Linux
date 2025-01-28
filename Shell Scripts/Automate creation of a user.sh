
#!/bin/bash
read -p "enter user name" user_name
echo $user_name
read -s -p "Enter the password" password
useradd -m $user_name
echo "user_name:$password" | sudo chpasswd 