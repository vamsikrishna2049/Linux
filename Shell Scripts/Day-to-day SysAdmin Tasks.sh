Day-to-day SysAdmin Tasks

### **1. Monitoring System Load and Alerting**

**Scenario:** Your team needs to monitor the system load regularly and get notified when the system load is too high. You can create a script that will:
- Check CPU load, memory usage, and disk I/O.
- Send an alert if the load exceeds a certain threshold.

#### **Task:**
- Monitor system resources (CPU, memory, disk usage).
- Send an email if thresholds are exceeded.

#### **Script:**

```bash
#!/bin/bash

# Thresholds
CPU_THRESHOLD=90
MEM_THRESHOLD=80
DISK_THRESHOLD=90
EMAIL="admin@example.com"
SUBJECT="System Load Alert"
BODY="High system load detected. Please check the server."

# Get CPU load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Get memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Get disk usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check CPU load
if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
    echo "High CPU load: $CPU_LOAD%" | mail -s "$SUBJECT" "$EMAIL"
fi

# Check Memory usage
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "High Memory usage: $MEM_USAGE%" | mail -s "$SUBJECT" "$EMAIL"
fi

# Check Disk usage
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "High Disk usage: $DISK_USAGE%" | mail -s "$SUBJECT" "$EMAIL"
fi
```

---

### **2. Automating System Updates**

**Scenario:** Your server needs to be regularly updated with security patches. Create a script that:
- Automatically checks for updates.
- Applies the updates.
- Reboots the server if necessary.

#### **Task:**
- Update all system packages.
- Reboot if necessary.

#### **Script:**

```bash
#!/bin/bash

# Update system packages
apt update && apt upgrade -y

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    echo "Reboot required. Rebooting now..."
    reboot
else
    echo "System updated. No reboot required."
fi
```

---

### **3. Managing and Rotating Logs**

**Scenario:** The logs in your server directory are becoming too large, and you need to rotate them automatically to prevent them from taking up too much disk space. You should:
- Compress and archive old logs.
- Delete logs that are older than a certain period.

#### **Task:**
- Rotate logs by compressing them.
- Delete old logs.

#### **Script:**

```bash
#!/bin/bash

LOG_DIR="/var/log"
ARCHIVE_DIR="/var/log/archive"
RETENTION_DAYS=30

# Compress and rotate logs
find $LOG_DIR -name "*.log" -exec gzip {} \;

# Move the compressed logs to the archive directory
find $LOG_DIR -name "*.log.gz" -exec mv {} $ARCHIVE_DIR \;

# Delete logs older than 30 days
find $ARCHIVE_DIR -name "*.log.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "Log rotation complete."
```

---

### **4. Backup and Restore Important Files**

**Scenario:** You need to back up important files to a remote server. You should:
- Use `rsync` to back up files.
- Schedule the backup to run regularly.

#### **Task:**
- Back up files to a remote server.
- Use cron to automate the backup.

#### **Script:**

```bash
#!/bin/bash

# Define source and destination directories
SOURCE_DIR="/home/user/data"
DEST_DIR="/remote/server:/backup"
LOG_FILE="/var/log/backup.log"

# Use rsync to backup data to remote server
rsync -avz --delete $SOURCE_DIR $DEST_DIR >> $LOG_FILE

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "$(date) - Backup successful" >> $LOG_FILE
else
    echo "$(date) - Backup failed" >> $LOG_FILE
    exit 1
fi
```

To automate this, you can add a cron job:

```bash
crontab -e
```

Add the following line to run the backup every day at 2 AM:

```bash
0 2 * * * /path/to/backup_script.sh
```

---

### **5. User Account Management**

**Scenario:** You need to manage user accounts by adding, deleting, or modifying users on your system. You can automate these tasks with a script that:
- Creates new users.
- Sets up passwords for new users.
- Removes inactive users.

#### **Task:**
- Create a new user.
- Delete users that have been inactive for 30 days.

#### **Script:**

```bash
#!/bin/bash

# Create a new user with a password
create_user() {
    USERNAME=$1
    PASSWORD=$2
    useradd -m -s /bin/bash $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "User $USERNAME created."
}

# Delete users that have been inactive for more than 30 days
delete_inactive_users() {
    INACTIVE_USERS=$(awk -F: '{ if ($5 > 30) print $1 }' /etc/passwd)

    for USER in $INACTIVE_USERS; do
        userdel -r $USER
        echo "User $USER deleted due to inactivity."
    done
}

# Example Usage
create_user "newuser" "securepassword"
delete_inactive_users
```

---

### **6. Check and Restart Services**

**Scenario:** You need to ensure that critical services (like NGINX, MySQL, etc.) are running. If any service is stopped, you want to restart it and send a notification.

#### **Task:**
- Check if services are running.
- Restart them if they are not.
- Send a notification email if a service is restarted.

#### **Script:**

```bash
#!/bin/bash

# Services to check
SERVICES=("nginx" "mysql" "ssh")

# Email to notify
EMAIL="admin@example.com"
SUBJECT="Service Restart Alert"
BODY="One or more services were restarted."

for SERVICE in "${SERVICES[@]}"; do
    systemctl is-active --quiet $SERVICE
    if [ $? -ne 0 ]; then
        # Service is not running, restart it
        systemctl restart $SERVICE

        if [ $? -eq 0 ]; then
            echo "$SERVICE was restarted successfully." | mail -s "$SUBJECT" "$EMAIL"
        else
            echo "Failed to restart $SERVICE" | mail -s "$SUBJECT" "$EMAIL"
        fi
    else
        echo "$SERVICE is running."
    fi
done
```

---

### **7. Checking and Cleaning Up Old Files**

**Scenario:** Your system is running out of space due to large, old files that are no longer needed. Create a script that:
- Finds and deletes files older than a certain period (e.g., 30 days).
- Logs the files that were deleted.

#### **Task:**
- Find and delete files older than 30 days.
- Log the deleted files.

#### **Script:**

```bash
#!/bin/bash

# Directories to check
DIRS=("/tmp" "/var/log")

# Delete files older than 30 days
for DIR in "${DIRS[@]}"; do
    find $DIR -type f -mtime +30 -exec rm -f {} \;
    echo "$(date) - Deleted files older than 30 days in $DIR" >> /var/log/file_cleanup.log
done
```

---

### **8. Network Monitoring and Reporting**

**Scenario:** You need to monitor the network interfaces and ensure they are up and running. The script should:
- Check if the network interfaces are active.
- Report the status of each interface.

#### **Task:**
- Check the status of network interfaces.
- Send a notification if an interface is down.

#### **Script:**

```bash
#!/bin/bash

# Network interfaces to check
INTERFACES=("eth0" "wlan0")

# Check each interface
for INTERFACE in "${INTERFACES[@]}"; do
    if ! ip link show $INTERFACE | grep -q "state UP"; then
        echo "Network interface $INTERFACE is down. Please check the connection."
    else
        echo "Network interface $INTERFACE is up."
    fi
done
```

---

### **9. Automatically Expire Passwords and Force a Change**

**Scenario:** For security reasons, user passwords need to be changed regularly. You want to automate the expiration of passwords after 30 days and notify users to change their passwords.

#### **Task:**
- Expire passwords after 30 days.
- Send users a notification to change their passwords.

#### **Script:**

```bash
#!/bin/bash

# Expire all user passwords after 30 days
chage -M 30 $1

# Send an email to the user notifying them to change their password
USER=$1
echo "Your password has expired. Please change it as soon as possible." | mail -s "Password Expiration Notice" "$USER@example.com"
```

---

### **10. System Health Report**

**Scenario:** You want to generate a system health report that provides information on CPU usage, memory, disk usage, and the status of key services. This report should be sent to the system administrator.

#### **Task:**
- Gather system health information.
- Generate and send the report.

#### **Script:**

```bash
#!/bin/bash

# Define log file and email
LOG_FILE="/var/log/system_health.log"
EMAIL="admin@example.com"

# System health information
echo "System Health Report - $(date)" > $LOG_FILE
echo "-------------------------------" >> $LOG_FILE
echo "CPU Usage:" >> $LOG_FILE
top -bn1 | grep "Cpu(s)" >> $LOG_FILE
echo "Memory Usage:" >> $LOG_FILE
free -h >> $LOG_FILE
echo "Disk Usage:" >> $LOG_FILE
df -h >> $LOG_FILE
echo "-------------------------------" >> $LOG_FILE
echo "Services Status:" >> $LOG_FILE
systemctl list-units --type=service >> $LOG_FILE

# Send report to the administrator
mail -s "System Health Report" "$EMAIL" < $LOG_FILE
```
