10 Process are running and stop first 5 process 

run the 3 proocess in background and 

last 2 Process going to send an notification once it is completed

#!/bin/bash

# Function to send notifications
send_notification() {
    local pid=$1
    echo "Process with PID $pid completed."
    notify-send "Process $pid Completed"  # For Linux (replace with osascript for macOS)
    # For macOS (uncomment the next line for macOS):
    # osascript -e 'display notification "Process $pid completed" with title "Process Complete"'
}

# Step 1: Get the list of PIDs of the running processes
pids=($(ps -e --sort=pid -o pid=))  # List of PIDs excluding headers, sorted by PID

# Check if we have at least 10 processes
if [ ${#pids[@]} -lt 10 ]; then
    echo "Error: Less than 10 processes are running. Please ensure at least 10 processes are active."
    exit 1
fi

# Display total number of processes
echo "Total Processes: ${#pids[@]}"

# Step 2: Stop the first 5 processes
echo "Stopping the first 5 processes..."
for pid in "${pids[@]:0:5}"; do
    echo "Stopping process with PID $pid..."
    kill -STOP "$pid" 2>/dev/null  # Stop the process (handle errors silently)
done

# Step 3: Run the next 3 processes in the background
echo "Running the next 3 processes in the background..."
for pid in "${pids[@]:5:3}"; do
    echo "Running process with PID $pid in the background..."
    # Simulate process running in the background (replace with actual process commands)
    sleep 10 &  # Sleep for 10 seconds as a placeholder for a real process
done

# Step 4: Process the last 2 processes and send notifications
echo "Running last 2 processes..."
for pid in "${pids[@]:8:2}"; do
    echo "Running process with PID $pid..."
    # Simulate process running (replace with actual command if needed)
    sleep 10  # Simulate the process running for 10 seconds
    send_notification $pid  # Send a notification when the process is completed
done

echo "All tasks completed!"
