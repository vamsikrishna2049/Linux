# Write a script to clean up unused Docker images, containers, and volumes.

#!/bin/bash

#Unsed docker container
docker container prune -f

#unsed docker images
docker image prune -f

#unsed docker volumes
docker volume prune -f
