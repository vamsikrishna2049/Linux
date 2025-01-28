#Write a shell script that accepts a directory as an argument and counts the number of files and directories within that directory.

#!/bin/bash
#Checking Directory is available
directory="/root/venkata"
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' is not available"
    exit 1
else
    echo "Directory '$directory' is available"
fi

#Count files and Directories 
file_count=0
dir_count=0

for entry in "$directory"/*; do
    if [ -f "$entry" ]; then
        file_count=$((file_count + 1))
    elif [ -d "$entry" ]; then
        dir_count=$((dir_count + 1))
    fi
done
echo "Total Files Count: $file_count"
echo "Total Directory's Count: $dir_count"