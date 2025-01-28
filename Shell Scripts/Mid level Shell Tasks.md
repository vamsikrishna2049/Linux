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

### **Next Steps:**
- Start writing scripts that automate your daily or system administration tasks.
- Work with more complex file manipulation tasks, including regular expressions and text parsing.
- Explore more advanced topics like process management, creating your own libraries of functions, and working with databases in shell scripts.
