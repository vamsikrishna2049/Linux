**Error Handling and Logging** are essential parts of writing robust shell scripts. They help track failures and ensure that the script performs as expected, even when something goes wrong. Proper error handling prevents your script from silently failing and allows you to take corrective action or notify the user.

Let's dive into **Error Handling** and **Logging** in shell scripts!

---

### **1. Error Handling in Shell Scripting**

Error handling ensures that your script can react appropriately when things go wrong. In bash, this is often done by checking the **exit status** of commands and handling failures.

#### **1.1 Exit Status**

Each command in Unix/Linux returns an **exit status** (or **return code**), which indicates whether the command succeeded or failed. By convention:

- **Exit Status 0**: Indicates success.
- **Exit Status Non-zero**: Indicates failure (1 is commonly used for general errors).

You can access the exit status of the last executed command using the special variable `$?`.

#### **1.2 Checking for Errors**

You can check the exit status after each command using `if` statements or by using `set -e` to exit the script immediately on any command failure.

##### **Example: Checking Exit Status Using `if`**

```bash
#!/bin/bash

echo "Starting script..."

# Run a command
mkdir /path/to/directory

# Check if the command succeeded
if [ $? -ne 0 ]; then
    echo "Error: Failed to create directory!"
    exit 1  # Exit with an error code
else
    echo "Directory created successfully!"
fi
```

In this script:
- `mkdir /path/to/directory`: If it fails, `$?` will be non-zero.
- The `if` block checks the exit status of `mkdir`. If the exit status is non-zero, it prints an error message and exits the script.

##### **Example: Using `set -e` to Exit on Error**

You can also use `set -e` to make the script exit immediately if any command fails:

```bash
#!/bin/bash

set -e  # Exit on error

echo "Starting script..."

# This command will fail if the directory exists
mkdir /path/to/directory

echo "Directory created successfully!"
```

In this case, if any command fails (e.g., `mkdir` fails), the script stops immediately without executing further commands.

#### **1.3 Handling Errors with `trap`**

The `trap` command allows you to run a specific command when an error occurs or when the script exits.

##### **Example: Using `trap` for Error Handling**

```bash
#!/bin/bash

# Define a function to run on error or exit
cleanup() {
    echo "An error occurred. Cleaning up..."
}

# Set the trap to call cleanup on any error or exit
trap cleanup EXIT

echo "Starting script..."

# This command will fail if the directory exists
mkdir /path/to/directory

echo "Directory created successfully!"
```

In this case, the `cleanup` function will be called whenever the script exits (whether it exits due to success or failure).

---

### **2. Logging in Shell Scripts**

Logging is crucial to track the script’s execution and understand its behavior, especially in production environments. You can log the output of commands and errors to a log file for later review.

#### **2.1 Basic Logging with `echo`**

A simple approach is to redirect `stdout` and `stderr` to a log file.

##### **Example: Basic Logging**

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"

echo "Script started at $(date)" >> $LOGFILE

# Run a command and log output
echo "Running mkdir command..." >> $LOGFILE
mkdir /path/to/directory >> $LOGFILE 2>&1

echo "Script ended at $(date)" >> $LOGFILE
```

In this script:
- `>> $LOGFILE`: Appends output to the log file.
- `2>&1`: Redirects `stderr` (error output) to `stdout` (regular output), so both are written to the log file.

#### **2.2 Logging with Timestamps**

Including timestamps in your logs is useful to track exactly when an event occurred.

##### **Example: Logging with Timestamps**

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

log_message "Script started"

# Run a command and log output
log_message "Running mkdir command..."
mkdir /path/to/directory >> $LOGFILE 2>&1

log_message "Script finished"
```

In this script:
- `log_message` function is defined to add a timestamp to the log file.
- `$(date '+%Y-%m-%d %H:%M:%S')`: This gives a human-readable timestamp.

#### **2.3 Handling Errors and Logging**

You can handle errors and log them separately in your script for better debugging.

##### **Example: Logging Errors**

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"
ERRORFILE="/path/to/errorfile.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" >> $ERRORFILE
}

log_message "Script started"

# Run a command and log success or failure
if mkdir /path/to/directory >> $LOGFILE 2>&1; then
    log_message "Directory created successfully."
else
    log_error "Failed to create directory."
    exit 1
fi

log_message "Script finished"
```

In this example:
- **Success logs** go into `$LOGFILE`.
- **Error logs** go into a separate `$ERRORFILE`.
- If the `mkdir` command fails, the error is logged in the error log, and the script exits with an error code.

#### **2.4 Using `tee` to Log Output**

`tee` is a useful command that allows you to display output to both the terminal and a log file simultaneously.

##### **Example: Logging and Displaying Output Simultaneously**

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"

echo "Starting script..." | tee -a $LOGFILE

# Run a command and log output, both on screen and to the file
echo "Running mkdir command..." | tee -a $LOGFILE
mkdir /path/to/directory | tee -a $LOGFILE 2>&1

echo "Script finished." | tee -a $LOGFILE
```

In this script:
- `tee -a $LOGFILE`: Appends output to the log file and also displays it on the terminal.
- The output of `mkdir` is shown on the terminal and saved to the log file.

---

### **3. Combining Error Handling and Logging**

The best practice is to combine both **error handling** and **logging**. This way, you can both react to errors and keep a record of what happened.

##### **Example: Full Script with Error Handling and Logging**

```bash
#!/bin/bash

LOGFILE="/path/to/logfile.log"
ERRORFILE="/path/to/errorfile.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOGFILE
}

log_error() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" >> $ERRORFILE
}

log_message "Script started"

# Run a command and log success or failure
if mkdir /path/to/directory >> $LOGFILE 2>&1; then
    log_message "Directory created successfully."
else
    log_error "Failed to create directory."
    exit 1
fi

log_message "Script finished"
```

In this combined script:
- The script logs its progress, along with any errors.
- If an error occurs, it is logged to a separate error file and the script exits immediately.

---

### **Summary of Error Handling and Logging Techniques:**

1. **Exit Status**: Use `$?` to check whether a command was successful.
2. **`set -e`**: Automatically exits the script when any command fails.
3. **`trap`**: Defines custom cleanup behavior when an error or exit occurs.
4. **Basic Logging**: Redirect output to a file using `>> logfile.log`.
5. **Timestamps**: Use `$(date)` to include timestamps in logs for better tracking.
6. **Error Logging**: Separate error logs from regular logs for better debugging.
7. **Simultaneous Display and Logging**: Use `tee` to display output to the terminal and log it at the same time.

### **Next Steps:**
- Try writing scripts with logging to track their behavior over time.
- Experiment with different types of logging, such as logging to files or sending logs to external services.
