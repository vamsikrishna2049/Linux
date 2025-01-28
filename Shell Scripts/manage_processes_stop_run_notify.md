Write a shell script to manage running processes by stopping the first five, running the next three in the background, and waiting for the last two to complete, sending notifications when they finish.


```bash
#!/bin/bash

# Author: 
# Description: 
# In your linux machine, example 10 Process are running and you need to stop first 5 process, run the 3 proocess in background and 
# last 2 Process going to send an notification once it is completed. 
# Version: v1
# Email: 
#

# Get the list of running processes (excluding the current script and system processes)
process_list=$(ps -e --no-headers | awk '{print $1}')  # Get PIDs of running processes

# Count to keep track of process numbers
counter=1

# Stop the first 5 processes - It stops the first five processes.
for pid in $process_list; do
    if [ $counter -le 5 ]; then
        echo "Stopping process with PID: $pid"
        kill $pid
        counter=$((counter + 1))
    fi
done

# Run the next 3 processes in the background 
# It runs the next three processes in the background (effectively killing them).
counter=1
for pid in $process_list; do
    if [ $counter -gt 5 ] && [ $counter -le 8 ]; then
        echo "Running process with PID: $pid in background"
        nohup kill $pid &  # Run in background
        counter=$((counter + 1))
    fi
done

# Wait for the last 2 processes to complete, then send a notification
# It waits for the last two processes to finish and sends a notification when they complete.
counter=1
for pid in $process_list; do
    if [ $counter -gt 8 ]; then
        echo "Waiting for process with PID: $pid to complete"
        wait $pid
        # Send a desktop notification when the process completes
        notify-send "Process with PID $pid completed"
        counter=$((counter + 1))
    fi
done
```