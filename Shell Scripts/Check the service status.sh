#!/bin/bash

# Author: 
# Description: Check the status of a service - If it is in stopped stage, then start and vice-versa
# Version: v1
# Email: 
#

# mention the service name
service_name="nginx"

# Check the status of a service
status=$(systemctl is-active $service_name)

if [ "$status" = "active" ]; then
    # If nginx is running, stop the service
    echo "$service_name is running. Stopping the service..."
    sudo systemctl stop $service_name
    echo "$service_name has been stopped."

elif [ "$status" = "inactive" ]; then
    # If nginx is stopped, start the service
    echo "$service_name is stopped. Starting the service..."
    sudo systemctl start $service_name
    echo "$service_name has been started."

else
    echo "Unable to determine the status of $service_name."
fi