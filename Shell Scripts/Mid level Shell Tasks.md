At the intermediate stage of learning shell scripting, you're expected to handle more complex tasks that involve decision-making, loops, functions, working with files, and interacting with system processes. Here are some tasks that will help you build your intermediate-level shell scripting skills:

---

### **1. Process Automation with Loops and Conditionals**
You'll likely be using loops and conditionals to automate repetitive tasks and handle different conditions based on the environment or inputs.

#### **Example Task: Backing Up Files Automatically**

Write a script that:
- Backs up a directory to a backup location.
- Only backs up if the source directory exists.
- Appends the date to the backup file name for versioning.

```bash
#!/bin/bash

SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
DATE=$(date +%F)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Check if the source directory exists
if [ -d "$SOURCE_DIR" ]; then
    echo "Backing up $SOURCE_DIR to $BACKUP_FILE"
    tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
else
    echo "Error: Source directory does not exist!"
    exit 1
fi
```

---

### **2. Working with File Handling**
Intermediate scripting often involves manipulating files—checking for file existence, creating, appending, or modifying files based on conditions.

#### **Example Task: Find Large Files**

Write a script that:
- Finds all files in a directory larger than a specified size.
- Prints the name and size of the file.
- Optionally, delete the files after listing them.

```bash
#!/bin/bash

DIRECTORY="/path/to/directory"
SIZE_LIMIT=1000000  # in bytes

# Find files larger than SIZE_LIMIT
find $DIRECTORY -type f -size +${SIZE_LIMIT}c -exec ls -lh {} \; | awk '{print $9 ": " $5}'

# Ask user if they want to delete the files
echo "Do you want to delete these files? (y/n)"
read answer
if [ "$answer" == "y" ]; then
    find $DIRECTORY -type f -size +${SIZE_LIMIT}c -exec rm -f {} \;
    echo "Files deleted."
else
    echo "Files not deleted."
fi
```

---

### **3. Handling User Input**
Shell scripts can be interactive, accepting user input to customize the behavior of the script.

#### **Example Task: User Input Validation**

Write a script that:
- Accepts a directory name from the user.
- Validates whether the directory exists.
- If the directory exists, list all files inside.
- If the directory doesn’t exist, prompt the user for a valid directory.

```bash
#!/bin/bash

# Prompt the user for a directory
echo "Please enter a directory path:"
read DIR_PATH

# Check if the directory exists
if [ -d "$DIR_PATH" ]; then
    echo "Listing contents of $DIR_PATH:"
    ls "$DIR_PATH"
else
    echo "Error: Directory does not exist. Please try again."
    exit 1
fi
```

---

### **4. Functions in Shell Scripts**
Intermediate scripts often involve defining and calling functions to make the script more modular and reusable.

#### **Example Task: Creating a Function to Check Disk Usage**

Write a script that:
- Defines a function to check disk usage on a specified mount point.
- If the disk usage exceeds a threshold, it sends a warning message.

```bash
#!/bin/bash

# Function to check disk usage
check_disk_usage() {
    THRESHOLD=80  # Percentage
    MOUNT_POINT=$1

    # Get the disk usage percentage
    USAGE=$(df "$MOUNT_POINT" | awk 'NR==2 {print $5}' | sed 's/%//')

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "Warning: Disk usage on $MOUNT_POINT is above $THRESHOLD% ($USAGE%)"
    else
        echo "Disk usage on $MOUNT_POINT is under control ($USAGE%)"
    fi
}

# Call the function with a mount point
check_disk_usage "/"
check_disk_usage "/home"
```

---

### **5. Scheduling Tasks with Cron (Advanced Scheduling)**
Cron jobs are a powerful way to schedule scripts to run automatically at specified intervals.

#### **Example Task: Schedule a Script to Run Weekly**

Write a script to:
- Automate the process of backing up files (as shown in Task 1) every week.
- Schedule this task using `cron` within the script.

```bash
#!/bin/bash

# Define backup command
BACKUP_COMMAND="/path/to/backup_script.sh"

# Schedule the cron job (weekly backup)
(crontab -l 2>/dev/null; echo "0 3 * * 1 $BACKUP_COMMAND") | crontab -

echo "Backup script has been scheduled to run every Monday at 3:00 AM."
```

This script sets up a cron job to run the backup script every Monday at 3:00 AM.

---

### **6. Parsing Command Line Arguments**
Many scripts need to accept arguments from the command line for flexibility.

#### **Example Task: Create a Script that Accepts Arguments**

Write a script that:
- Accepts a filename and an action (`create`, `delete`, or `append`).
- Performs the action on the file based on the user input.

```bash
#!/bin/bash

# Check for correct number of arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filename> <create|delete|append>"
    exit 1
fi

FILE=$1
ACTION=$2

case $ACTION in
    create)
        touch $FILE
        echo "File $FILE created."
        ;;
    delete)
        rm -f $FILE
        echo "File $FILE deleted."
        ;;
    append)
        echo "Appending text to $FILE."
        echo "This is an appended line." >> $FILE
        ;;
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac
```

---

### **7. Working with Network Tools**
Intermediate scripts often require network interaction, such as downloading files or interacting with remote servers.

#### **Example Task: Monitor a Website’s Availability**

Write a script that:
- Pings a website every minute to check if it is online.
- Logs the result with a timestamp.

```bash
#!/bin/bash

URL="http://example.com"
LOGFILE="/path/to/logfile.log"

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

    if [ "$RESPONSE" -eq 200 ]; then
        echo "$TIMESTAMP: $URL is up" >> $LOGFILE
    else
        echo "$TIMESTAMP: $URL is down (HTTP $RESPONSE)" >> $LOGFILE
    fi

    sleep 60  # Wait for 1 minute before checking again
done
```

---

### **8. Parsing and Processing Text Files**
Intermediate scripts often need to read, process, and manipulate text files.

#### **Example Task: Parse a Log File for Specific Entries**

Write a script that:
- Reads a log file.
- Extracts entries with a specific keyword (e.g., `ERROR`).
- Outputs the matching entries to another file.

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"
OUTPUTFILE="/path/to/errorlog.txt"

# Search for 'ERROR' in the log file and save to the output file
grep "ERROR" $LOGFILE > $OUTPUTFILE

echo "Error entries have been written to $OUTPUTFILE."
```

---

### **9. Managing Permissions and Ownership**
A common intermediate-level task is modifying file permissions and ownership programmatically.

#### **Example Task: Change Permissions and Ownership of Files**

Write a script that:
- Changes the ownership of files in a directory.
- Modifies permissions to give read/write access to the owner and only read access to others.

```bash
#!/bin/bash

DIRECTORY="/path/to/directory"

# Change ownership to a specific user and group
chown user:group $DIRECTORY/*

# Change permissions to rw-r--r--
chmod 644 $DIRECTORY/*

echo "Permissions and ownership updated."
```

---

### **10. Logging and Error Handling**
At this stage, you should be proficient in logging and error handling, ensuring your scripts are robust and informative.

#### **Example Task: Log Script Execution with Timestamp**

Write a script that:
- Logs the start and end time of its execution.
- Logs any errors encountered during execution.

```bash
#!/bin/bash

LOGFILE="/path/to/script.log"
ERRORFILE="/path/to/error.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" >> $ERRORFILE
}

log_message "Script started"

# Example operation
if ! ls /path/to/directory; then
    log_error "Failed to list directory."
    exit 1
fi

log_message "Script completed successfully."
```

---

Automating daily or system administration tasks can greatly improve efficiency and reduce the likelihood of errors. Here's a list of common tasks and sample scripts to help automate them:

### 1. **Automating System Updates (Linux)**

**Task**: Automatically update packages on your system.

**Script** (Bash - `auto_update.sh`):
```bash
#!/bin/bash

# Update the package lists
echo "Updating package list..."
sudo apt update

# Upgrade all packages
echo "Upgrading all packages..."
sudo apt -y upgrade

# Clean up unnecessary packages
echo "Cleaning up unused packages..."
sudo apt -y autoremove

# Reboot if necessary
if [ -f /var/run/reboot-required ]; then
    echo "Reboot required. Rebooting now..."
    sudo reboot
else
    echo "No reboot required."
fi
```

**How to use**:
- Save this script as `auto_update.sh`.
- Make it executable: `chmod +x auto_update.sh`.
- You can run it manually or schedule it using cron: `crontab -e` and add `0 2 * * * /path/to/auto_update.sh` for a daily update at 2 AM.

---

### 2. **Disk Space Monitoring (Linux)**

**Task**: Check disk usage and send an alert when disk space exceeds a threshold.

**Script** (Bash - `disk_usage_alert.sh`):
```bash
#!/bin/bash

# Set the threshold for disk space usage (e.g., 80%)
THRESHOLD=80

# Check disk usage
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Compare with the threshold and send an alert if over
if [ $USAGE -gt $THRESHOLD ]; then
    echo "Disk space is over ${THRESHOLD}%. Current usage: ${USAGE}%." | mail -s "Disk Usage Alert" user@example.com
fi
```

**How to use**:
- Save the script as `disk_usage_alert.sh`.
- Make it executable: `chmod +x disk_usage_alert.sh`.
- Set up a cron job to run it regularly: `crontab -e` and add `*/30 * * * * /path/to/disk_usage_alert.sh` to check every 30 minutes.

---

### 3. **Backup Files (Linux)**

**Task**: Automatically back up important files to a remote server or local backup location.

**Script** (Bash - `backup.sh`):
```bash
#!/bin/bash

# Define source and destination directories
SOURCE_DIR="/home/user/Documents/"
BACKUP_DIR="/backup/location/"
DATE=$(date +\%Y\%m\%d\%H\%M)

# Create backup
tar -czf ${BACKUP_DIR}backup_${DATE}.tar.gz $SOURCE_DIR

# Optionally, remove backups older than 7 days
find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -exec rm {} \;
```

**How to use**:
- Save this script as `backup.sh`.
- Make it executable: `chmod +x backup.sh`.
- Schedule it with cron to run daily: `crontab -e` and add `0 3 * * * /path/to/backup.sh` to back up daily at 3 AM.

---

### 4. **User Account Cleanup (Linux)**

**Task**: Remove users that have not logged in for a certain period.

**Script** (Bash - `user_cleanup.sh`):
```bash
#!/bin/bash

# Set the threshold (e.g., users who haven't logged in for 30 days)
THRESHOLD_DAYS=30

# Find users who have not logged in for more than THRESHOLD_DAYS
for user in $(awk -F: '{ print $1 }' /etc/passwd); do
    last_login=$(lastlog -u $user | awk 'NR==2 {print $4, $5, $6}')
    if [[ -z "$last_login" || $(date -d "$last_login" +%s) -lt $(date -d "-$THRESHOLD_DAYS days" +%s) ]]; then
        echo "Deleting user: $user"
        sudo userdel -r $user
    fi
done
```

**How to use**:
- Save the script as `user_cleanup.sh`.
- Make it executable: `chmod +x user_cleanup.sh`.
- Schedule it via cron to run weekly: `crontab -e` and add `0 0 * * 0 /path/to/user_cleanup.sh` for weekly execution.

---

### 5. **Automating System Reboot (Linux)**

**Task**: Automatically reboot the system at a specified time.

**Script** (Bash - `system_reboot.sh`):
```bash
#!/bin/bash

# Reboot the system at 2 AM every day
echo "Rebooting system..."
sudo shutdown -r 02:00
```

**How to use**:
- Save the script as `system_reboot.sh`.
- Make it executable: `chmod +x system_reboot.sh`.
- You can schedule it to run daily using cron: `crontab -e` and add `0 1 * * * /path/to/system_reboot.sh`.

---

### 6. **Disk Space Monitoring and Cleanup (Windows)**

**Task**: Monitor disk space and delete temporary files if a certain threshold is exceeded.

**Script** (PowerShell - `DiskCleanup.ps1`):
```powershell
# Set threshold in percentage
$threshold = 80

# Get disk usage
$disk = Get-PSDrive C
$usedSpace = $disk.Used / $disk.UsedMaximum * 100

# If disk usage is greater than the threshold
if ($usedSpace -gt $threshold) {
    Write-Host "Disk usage is over $threshold%. Cleaning up..."
    # Delete temporary files
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force
    Remove-Item -Path "C:\Users\$env:USERNAME\AppData\Local\Temp\*" -Recurse -Force
    Write-Host "Cleanup completed."
} else {
    Write-Host "Disk space usage is within acceptable limits."
}
```

**How to use**:
- Save the script as `DiskCleanup.ps1`.
- Run the script via Task Scheduler to automate it (e.g., every week).

---
Certainly! Working with complex file manipulation tasks often involves using regular expressions (regex) and text parsing to extract, modify, and clean data. Here are some examples of how you can use bash (Linux) and PowerShell (Windows) to handle complex file manipulation tasks, including regular expressions and text parsing.

### 1. **Extracting Specific Information from Logs (Linux)**
**Task**: Extract log entries from a system log file for a specific user and filter out errors using regular expressions.

**Script** (Bash - `extract_log.sh`):
```bash
#!/bin/bash

# Log file location
LOG_FILE="/var/log/syslog"

# Regex pattern to match log entries for a specific user (e.g., 'john') and containing 'error'
USER="john"
PATTERN=".*$USER.*error.*"

# Extract matching lines from the log file
grep -E "$PATTERN" $LOG_FILE > "error_logs_$USER.txt"

# Output the number of lines found
LINE_COUNT=$(wc -l < "error_logs_$USER.txt")
echo "Found $LINE_COUNT error entries for user $USER."
```

**Explanation**:
- The `grep -E` command is used to perform a regular expression match. It filters out lines containing both the specified user (`$USER`) and the word `error`.
- The result is saved to a file (`error_logs_$USER.txt`), and the script counts how many lines matched.

**How to use**:
- Save the script as `extract_log.sh`.
- Make it executable: `chmod +x extract_log.sh`.
- You can run it manually, or automate it using cron.

---

### 2. **Parsing and Formatting a CSV File (Linux)**

**Task**: Parse a CSV file, filter rows based on certain criteria, and format the output into a new CSV.

**Script** (Bash - `parse_csv.sh`):
```bash
#!/bin/bash

# Input and output CSV file locations
INPUT_FILE="data.csv"
OUTPUT_FILE="filtered_data.csv"

# Regex to match rows where the second column is greater than 50
PATTERN="^[^,]*,[^,]*,[5-9][0-9]*$"

# Write header to output file
head -n 1 $INPUT_FILE > $OUTPUT_FILE

# Parse through each line, filter, and append to the output file
tail -n +2 $INPUT_FILE | while IFS=',' read -r col1 col2 col3; do
    if [[ "$col2" =~ ^[5-9][0-9]*$ ]]; then
        echo "$col1,$col2,$col3" >> $OUTPUT_FILE
    fi
done

echo "Filtered rows have been written to $OUTPUT_FILE."
```

**Explanation**:
- This script processes a CSV file (`data.csv`), filters out rows where the second column is greater than 50, and saves the result to a new CSV file (`filtered_data.csv`).
- `head -n 1` grabs the header, and `tail -n +2` skips the header for row processing.
- A regular expression (`^[^,]*,[^,]*,[5-9][0-9]*$`) is used to check if the second column meets the filter criteria.

**How to use**:
- Save this script as `parse_csv.sh`.
- Make it executable: `chmod +x parse_csv.sh`.
- Run it manually or schedule it using cron.

---

### 3. **Replacing Text in Files Based on Regex (Linux)**

**Task**: Replace occurrences of an IP address with a placeholder using regex.

**Script** (Bash - `replace_ip.sh`):
```bash
#!/bin/bash

# Input file
INPUT_FILE="network_config.txt"

# Regex to match an IP address (simple IPv4 pattern)
PATTERN='([0-9]{1,3}\.){3}[0-9]{1,3}'

# Replace the IP addresses with a placeholder
sed -E "s/$PATTERN/XXX.XXX.XXX.XXX/g" $INPUT_FILE > "updated_network_config.txt"

echo "IP addresses have been replaced with placeholders."
```

**Explanation**:
- This script uses `sed` (stream editor) to find all IP addresses in the file and replace them with a placeholder `XXX.XXX.XXX.XXX`.
- The regex `([0-9]{1,3}\.){3}[0-9]{1,3}` is a simple pattern to match IPv4 addresses.

**How to use**:
- Save the script as `replace_ip.sh`.
- Make it executable: `chmod +x replace_ip.sh`.
- You can run it manually or use cron to automate it.

---

### 4. **Text Parsing and Transformation (Windows PowerShell)**

**Task**: Extract usernames and email addresses from a text file and transform them into a CSV format.

**Script** (PowerShell - `parse_emails.ps1`):
```powershell
# Input text file location
$inputFile = "users.txt"
$outputFile = "users.csv"

# Read the file line by line and process it
$users = Get-Content $inputFile | ForEach-Object {
    # Use regex to match usernames and emails
    if ($_ -match "^(.*)\s*<([^>]+)>$") {
        # Capture username and email
        $username = $matches[1]
        $email = $matches[2]
        
        # Create a custom object for each match
        [PSCustomObject]@{
            Username = $username
            Email = $email
        }
    }
}

# Export results to a CSV file
$users | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Usernames and emails have been extracted and saved to $outputFile."
```

**Explanation**:
- This script uses a regular expression to capture a username and email from a text file, where each line has the format: `username <email>`.
- The regular expression `^(.*)\s*<([^>]+)>$` captures everything before the `<` as the username and everything inside the `<...>` as the email.
- It then outputs the data into a CSV file (`users.csv`).

**How to use**:
- Save the script as `parse_emails.ps1`.
- Run it in PowerShell, and the extracted data will be written to `users.csv`.

---

### 5. **Text File Search and Replace with Regular Expressions (Windows PowerShell)**

**Task**: Search for patterns in a file and replace specific words using regular expressions.

**Script** (PowerShell - `replace_text.ps1`):
```powershell
# Input file
$inputFile = "textfile.txt"

# Regex to find all occurrences of the word 'error'
$pattern = "error"

# Replace 'error' with 'issue'
(Get-Content $inputFile) | ForEach-Object {
    $_ -replace $pattern, "issue"
} | Set-Content "updated_textfile.txt"

Write-Host "All 'error' occurrences have been replaced with 'issue'."
```

**Explanation**:
- This script reads a file (`textfile.txt`), searches for the word "error" using a regular expression, and replaces it with "issue".
- The updated content is written to a new file (`updated_textfile.txt`).

**How to use**:
- Save the script as `replace_text.ps1`.
- Run it in PowerShell, and the replaced text will be saved to `updated_textfile.txt`.

---

### 6. **Extracting Specific Data from HTML Files (Linux)**

**Task**: Extract all email addresses from an HTML file using regex.

**Script** (Bash - `extract_emails.sh`):
```bash
#!/bin/bash

# Input HTML file
INPUT_FILE="page.html"

# Regex pattern for extracting email addresses
PATTERN='[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'

# Extract email addresses using grep and regex
grep -oE "$PATTERN" $INPUT_FILE > "extracted_emails.txt"

# Count how many email addresses were found
LINE_COUNT=$(wc -l < "extracted_emails.txt")
echo "Extracted $LINE_COUNT email addresses."
```

**Explanation**:
- This script uses `grep -oE` to extract email addresses from the HTML file (`page.html`), matching the provided regex pattern for emails.
- The result is saved in a file (`extracted_emails.txt`), and the script outputs the number of found email addresses.

**How to use**:
- Save the script as `extract_emails.sh`.
- Make it executable: `chmod +x extract_emails.sh`.
- Run it manually or use cron to automate it.

---
Advanced shell scripting techniques often include process management, creating reusable libraries of functions, and interacting with databases. These techniques are essential for writing efficient, scalable, and maintainable automation scripts. Let’s explore these topics in detail with examples.

### 1. **Process Management in Shell Scripts**

**Process management** involves controlling and monitoring processes running on the system. This includes starting, stopping, and checking the status of processes, as well as handling background jobs and process IDs (PIDs).

#### **Example 1: Managing Processes in Shell Script**

**Task**: Monitor a process, restart it if it stops, and log the status.

**Script** (Bash - `process_monitor.sh`):
```bash
#!/bin/bash

# Name of the process to monitor
PROCESS_NAME="myapp"
LOG_FILE="/var/log/process_monitor.log"

# Function to check if the process is running
check_process() {
    pgrep "$PROCESS_NAME" > /dev/null 2>&1
}

# Function to start the process
start_process() {
    echo "$(date): Starting $PROCESS_NAME" >> $LOG_FILE
    # Replace with the actual command to start your process
    /path/to/myapp &
}

# Check if the process is running
if check_process; then
    echo "$(date): $PROCESS_NAME is already running." >> $LOG_FILE
else
    echo "$(date): $PROCESS_NAME is not running." >> $LOG_FILE
    start_process
fi
```

**Explanation**:
- `pgrep "$PROCESS_NAME"` checks if the process is running by searching for it in the process table. If it finds the process, it returns `0`, meaning the process is running.
- `start_process` starts the process in the background.
- Logs actions and status to a file (`process_monitor.log`).

**How to use**:
- Save the script as `process_monitor.sh`.
- Make it executable: `chmod +x process_monitor.sh`.
- You can run it manually or automate it with a cron job to monitor the process at regular intervals.

---

#### **Example 2: Background Process Management**

**Task**: Run a command in the background, capture its PID, and allow for killing it if necessary.

**Script** (Bash - `background_task.sh`):
```bash
#!/bin/bash

# Start a long-running process in the background
./long_running_task.sh &
PROCESS_PID=$!

# Save the PID to a file for later management
echo $PROCESS_PID > "process_pid.txt"

# Monitor the process
echo "Process started with PID: $PROCESS_PID"

# Wait for the process to complete
wait $PROCESS_PID

# After completion
echo "Process $PROCESS_PID has finished."
```

**Explanation**:
- The script starts a long-running task (`long_running_task.sh`) in the background by appending `&` to the command.
- The `$!` variable captures the PID of the last background process.
- The script waits for the process to finish with `wait`.

**How to use**:
- Save the script as `background_task.sh`.
- Make it executable: `chmod +x background_task.sh`.
- You can use this to run any long-running command and manage its PID.

---

### 2. **Creating Your Own Libraries of Functions**

In more complex scripts, you may want to modularize your code and make it reusable by creating a library of functions. This allows you to maintain a clean structure and reuse code across different scripts.

#### **Example: Creating a Shell Script Library**

**Task**: Create a reusable library of functions for file manipulation.

**Script** (Bash - `file_utils.sh`):
```bash
#!/bin/bash

# Function to check if a file exists
file_exists() {
    if [ -e "$1" ]; then
        echo "File $1 exists."
    else
        echo "File $1 does not exist."
    fi
}

# Function to create a backup of a file
backup_file() {
    local file="$1"
    local backup_file="${file}_backup_$(date +%Y%m%d%H%M%S)"
    cp "$file" "$backup_file"
    echo "Backup of $file created as $backup_file."
}

# Function to count the number of lines in a file
line_count() {
    wc -l < "$1"
}

```

**Explanation**:
- `file_exists` checks whether a file exists.
- `backup_file` creates a backup of the given file with a timestamp.
- `line_count` counts the number of lines in the specified file.

#### **Using the Library in Another Script**:
You can source the library in another script to use the functions.

**Script** (Bash - `use_file_utils.sh`):
```bash
#!/bin/bash

# Source the file_utils.sh library
source /path/to/file_utils.sh

# Example usage of functions from the library
file_exists "/path/to/file.txt"
backup_file "/path/to/file.txt"
LINE_COUNT=$(line_count "/path/to/file.txt")
echo "The file contains $LINE_COUNT lines."
```

**Explanation**:
- The `source` command is used to include the `file_utils.sh` script, making its functions available in the current script.
- Functions from `file_utils.sh` are used to check for the file, create backups, and count lines.

**How to use**:
- Save the utility functions as `file_utils.sh`.
- In the script that uses the library, ensure that you call `source /path/to/file_utils.sh` to load the functions.
- Make both scripts executable: `chmod +x file_utils.sh use_file_utils.sh`.

---

### 3. **Working with Databases in Shell Scripts**

Shell scripts can interact with databases (like MySQL, PostgreSQL, SQLite, etc.) to automate tasks such as querying, inserting, and updating data.

#### **Example 1: MySQL Database Interaction (Bash)**

**Task**: Write a shell script that queries a MySQL database and processes the results.

**Script** (Bash - `mysql_query.sh`):
```bash
#!/bin/bash

# Database credentials
DB_USER="root"
DB_PASS="password"
DB_NAME="example_db"

# Query to execute
QUERY="SELECT id, name FROM users WHERE active = 1;"

# Run the query and capture the results
mysql -u$DB_USER -p$DB_PASS -D$DB_NAME -e "$QUERY" > query_results.txt

# Check if the query was successful
if [ $? -eq 0 ]; then
    echo "Query executed successfully. Results saved to query_results.txt"
else
    echo "Query execution failed."
fi
```

**Explanation**:
- The script connects to a MySQL database using `mysql` CLI, executes a query to select active users, and saves the results to `query_results.txt`.
- The `$?` checks the exit status of the `mysql` command to confirm success or failure.

**How to use**:
- Ensure MySQL is installed and accessible.
- Update the database credentials (`DB_USER`, `DB_PASS`, `DB_NAME`) with your own.
- Run the script: `./mysql_query.sh`.

---

#### **Example 2: SQLite Database Interaction (Bash)**

**Task**: Query an SQLite database and process the results.

**Script** (Bash - `sqlite_query.sh`):
```bash
#!/bin/bash

# SQLite database file
DB_FILE="example.db"

# Query to execute
QUERY="SELECT id, name FROM users WHERE active = 1;"

# Run the query and capture the results
sqlite3 $DB_FILE "$QUERY" > query_results.txt

# Check if the query was successful
if [ $? -eq 0 ]; then
    echo "Query executed successfully. Results saved to query_results.txt"
else
    echo "Query execution failed."
fi
```

**Explanation**:
- The script uses `sqlite3` to run a query on an SQLite database (`example.db`) and outputs the results to a text file.

**How to use**:
- Ensure that SQLite is installed and the database file (`example.db`) exists.
- Update the query to fit your use case.
- Run the script: `./sqlite_query.sh`.

---

### 4. **Advanced Database Operations: Insert Data**

**Task**: Insert data into a MySQL database via a shell script.

**Script** (Bash - `insert_data.sh`):
```bash
#!/bin/bash

# Database credentials
DB_USER="root"
DB_PASS="password"
DB_NAME="example_db"

# Data to insert
USER_NAME="John Doe"
USER_EMAIL="john.doe@example.com"

# Insert data into the users table
QUERY="INSERT INTO users (name, email) VALUES ('$USER_NAME', '$USER_EMAIL');"

# Execute the query
mysql -u$DB_USER -p$DB_PASS -D$DB_NAME -e "$QUERY"

# Check if the query was successful
if [ $? -eq 0 ]; then
    echo "Data inserted successfully."
else
    echo "Failed to insert data."
fi
```

**Explanation**:
- The script connects to the MySQL database and inserts a new row into the `users` table with the provided `name` and `email`.

**How to use**:
- Replace the database credentials and table structure with your own.
- Run the script: `./insert_data.sh`.

---

### Conclusion

In this exploration of advanced shell scripting topics, we have covered:
- **Process management**: Monitoring and managing processes, including starting, checking status, and restarting processes.
- **Creating reusable function libraries**: Modularizing code into libraries for easy reuse and maintenance.
- **Working with databases**: Querying and inserting data into databases (MySQL, SQLite) from shell scripts.
