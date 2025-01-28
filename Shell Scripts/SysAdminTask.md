## SYS Admin Tasks
---

### **1. Monitor Disk Space and Send an Alert**

**Scenario:** Your system is running low on disk space. You need to create a script that monitors the disk space every day and sends an email alert if disk usage exceeds a certain threshold.

#### **Task:**

- Monitor disk usage for any mounted file system.
- Send an email if the disk usage exceeds 80%.

#### **Script:**

```bash
#!/bin/bash

# Set threshold for disk usage
THRESHOLD=80
EMAIL="admin@example.com"
SUBJECT="Disk Space Alert"
BODY="Disk usage exceeds $THRESHOLD%. Please check the server."

# Get the disk usage percentage
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Compare disk usage with threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "$BODY" | mail -s "$SUBJECT" "$EMAIL"
    echo "Disk usage is above threshold. Alert sent."
else
    echo "Disk usage is below threshold. No action needed."
fi
```

---

### **2. Backup Important Files**

**Scenario:** You need to back up a directory containing important files on a daily basis. The script should:
- Create a compressed `.tar.gz` archive of the directory.
- Save the backup with the current date.
- Log the backup process.

#### **Task:**
- Back up a specific directory and compress the contents.
- Create a log for successful or failed backup attempts.

#### **Script:**

```bash
#!/bin/bash

SOURCE_DIR="/home/user/important_files"
BACKUP_DIR="/backup"
LOG_FILE="/var/log/backup_log.txt"
DATE=$(date +%Y-%m-%d)

# Backup file name
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Create a backup
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup successful: $BACKUP_FILE" >> $LOG_FILE
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Backup failed" >> $LOG_FILE
    exit 1
fi
```

You can use cron to schedule this task for daily execution.

---

### **3. User Account Management**

**Scenario:** You need to create new users, set their passwords, and assign them to specific groups. You also need to ensure that inactive users are disabled after a certain period.

#### **Task:**
- Create a script that:
  - Creates a new user with a default password.
  - Adds the user to the appropriate group.
  - Disables accounts that have been inactive for more than 30 days.

#### **Script:**

```bash
#!/bin/bash

# New user creation
create_user() {
    USERNAME=$1
    PASSWORD=$2
    GROUP=$3

    useradd -m -s /bin/bash -G $GROUP $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "User $USERNAME created and added to group $GROUP"
}

# Disable users who have been inactive for more than 30 days
disable_inactive_users() {
    INACTIVE_THRESHOLD=30
    INACTIVE_USERS=$(awk -F: '{ if ($5 > '"$INACTIVE_THRESHOLD"') print $1 }' /etc/passwd)

    for USER in $INACTIVE_USERS; do
        usermod -L $USER
        echo "User $USER disabled due to inactivity"
    done
}

# Call the functions
create_user "newuser" "securepassword" "developers"
disable_inactive_users
```

---

### **4. Service Monitoring and Restart**

**Scenario:** You need to ensure that important services (such as `nginx`, `mysql`, or `httpd`) are running. If any of these services stop, you should restart them automatically and send an alert.

#### **Task:**
- Monitor a list of important services.
- Restart any service that is not running.
- Send an email alert when a service is restarted.

#### **Script:**

```bash
#!/bin/bash

SERVICES=("nginx" "mysql" "httpd")
EMAIL="admin@example.com"
SUBJECT="Service Restarted"
BODY="One or more services were restarted."

for SERVICE in "${SERVICES[@]}"; do
    # Check if the service is running
    systemctl is-active --quiet $SERVICE
    if [ $? -ne 0 ]; then
        echo "$SERVICE is down. Restarting..."
        systemctl restart $SERVICE

        # Check if the restart was successful
        if [ $? -eq 0 ]; then
            echo "$SERVICE restarted successfully" | mail -s "$SUBJECT" "$EMAIL"
        else
            echo "Failed to restart $SERVICE" | mail -s "$SUBJECT" "$EMAIL"
        fi
    else
        echo "$SERVICE is running."
    fi
done
```

---

### **5. Log File Management**

**Scenario:** You need to clean up log files periodically to avoid excessive disk usage. Specifically:
- Rotate logs to prevent one large file from consuming too much space.
- Remove logs that are older than 30 days.

#### **Task:**
- Rotate log files (i.e., compress and archive them).
- Delete logs older than 30 days.

#### **Script:**

```bash
#!/bin/bash

LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archive"
RETENTION_DAYS=30

# Rotate logs by compressing them
find $LOG_DIR -name "*.log" -exec gzip {} \;

# Move compressed logs to an archive directory
find $LOG_DIR -name "*.log.gz" -exec mv {} $ARCHIVE_DIR \;

# Delete log files older than 30 days
find $ARCHIVE_DIR -name "*.log.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "Log rotation and cleanup complete."
```

You can set this up to run periodically using cron.

---

### **6. Monitoring System Load and Resources**

**Scenario:** You need to monitor system resource usage such as CPU load, memory usage, and disk I/O. If any resource exceeds a certain threshold, you should log the event and potentially notify the system administrator.

#### **Task:**
- Monitor CPU load, memory usage, and disk I/O.
- Log any events where the resource usage exceeds a threshold.

#### **Script:**

```bash
#!/bin/bash

# Set resource usage thresholds
CPU_THRESHOLD=90
MEM_THRESHOLD=80
DISK_THRESHOLD=90
LOG_FILE="/var/log/resource_usage.log"

# Get current CPU load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
# Get current memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
# Get current disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check if CPU load exceeds threshold
if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
    echo "$(date) - High CPU load: $CPU_LOAD%" >> $LOG_FILE
fi

# Check if memory usage exceeds threshold
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "$(date) - High Memory usage: $MEM_USAGE%" >> $LOG_FILE
fi

# Check if disk usage exceeds threshold
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "$(date) - High Disk usage: $DISK_USAGE%" >> $LOG_FILE
fi
```

---

### **7. Automated System Updates**

**Scenario:** You want to ensure that your system is always up to date with the latest security patches. The script should:
- Automatically update the system on a regular basis.
- Reboot the system if necessary.

#### **Task:**
- Update all installed packages.
- Reboot the system if required.

#### **Script:**

```bash
#!/bin/bash

# Update all system packages
echo "Starting system update..."
apt update && apt upgrade -y

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    echo "Reboot required. Rebooting now..."
    reboot
else
    echo "System updated. No reboot required."
fi
```

You can schedule this script to run regularly using `cron`.

---

### **8. System Health Check and Reporting**

**Scenario:** You want to create a script that checks the overall health of the system. It should check the status of important services, available disk space, and system load.

#### **Task:**
- Check system health status for services, disk space, and load.
- Generate a report and email it to the administrator.

#### **Script:**

```bash
#!/bin/bash

# Variables
EMAIL="admin@example.com"
SUBJECT="System Health Report"
REPORT="/tmp/system_health_report.txt"

# Check service status
SERVICES=("nginx" "mysql" "ssh")
for SERVICE in "${SERVICES[@]}"; do
    systemctl is-active --quiet $SERVICE
    if [ $? -eq 0 ]; then
        echo "$SERVICE is running." >> $REPORT
    else
        echo "$SERVICE is NOT running!" >> $REPORT
    fi
done

# Check disk space
df -h >> $REPORT

# Check system load
uptime >> $REPORT

# Send the report via email
mail -s "$SUBJECT" "$EMAIL" < $REPORT

# Clean up
rm -f $REPORT
```

---

### **9. Scheduling and Automating Tasks Using Cron**

**Scenario:** You want to automate regular maintenance tasks such as cleaning up old log files, performing backups, and running health checks on the system.

#### **Task:**
- Automate system tasks with `cron`.
- Schedule the backup script to run daily and the health check script weekly.

#### **Script:**

Use `crontab` to schedule tasks.

1. Open the crontab file:

```bash
crontab -e
```

2. Add the following cron jobs:

```bash
# Run backup every day at 2:00 AM
0 2 * * * /path/to/backup_script.sh

# Run health check every Sunday at 4:00 AM
0 4 * * 0 /path/to/health_check_script.sh
```

---

These are practical **sysadmin tasks** that involve managing users, processes, backups, monitoring resources, and automating maintenance. These tasks will help you sharpen your shell scripting skills and improve your ability to automate system administration processes.