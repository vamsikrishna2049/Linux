## Networking commands 

In bash are used to interact with and manage network-related tasks such as checking network connections, configuring network interfaces, diagnosing issues, and more. Below is a list of commonly used networking commands in bash and how you can use them in your scripts.

---

### **1. `ping` - Test Network Connectivity**

The `ping` command is used to check the connectivity between your machine and another system (usually using an IP address or hostname). It sends ICMP echo requests and waits for the response.

#### **Basic Usage**:

```bash
ping -c 4 google.com
```

- `-c 4`: Send 4 ping requests.
- This command will send 4 packets to `google.com` and show the round-trip time.

#### **Example in a script**:

```bash
#!/bin/bash

HOST="google.com"
ping -c 4 $HOST

if [ $? -eq 0 ]; then
    echo "Network is up"
else
    echo "Network is down"
fi
```

---

### **2. `ifconfig` / `ip` - Network Interface Configuration**

`ifconfig` is a legacy command used to view and configure network interfaces. In modern Linux systems, `ip` is preferred for managing network interfaces and routing.

#### **Using `ifconfig`**:

To view the status of network interfaces:

```bash
ifconfig
```

To bring a network interface up or down:

```bash
ifconfig eth0 up    # Bring eth0 up
ifconfig eth0 down  # Bring eth0 down
```

#### **Using `ip`** (modern alternative):

To show network interfaces and their status:

```bash
ip a
```

To bring an interface up or down:

```bash
ip link set eth0 up    # Bring eth0 up
ip link set eth0 down  # Bring eth0 down
```

#### **Example in a script**:

```bash
#!/bin/bash

INTERFACE="eth0"

# Check if the interface is up
if ip link show $INTERFACE | grep -q "state UP"; then
    echo "$INTERFACE is up"
else
    echo "$INTERFACE is down"
fi
```

---

### **3. `netstat` - Network Statistics**

`netstat` shows active network connections, routing tables, interface statistics, etc. It's a useful tool for diagnosing network issues.

#### **Basic Usage**:

To list all active connections:

```bash
netstat -tuln
```

- `-t`: Show TCP connections.
- `-u`: Show UDP connections.
- `-l`: Show listening sockets.
- `-n`: Show numerical addresses (avoid resolving hostnames).

#### **Example in a script**:

```bash
#!/bin/bash

# List all listening ports and their associated services
netstat -tuln
```

---

### **4. `nslookup` / `dig` - DNS Lookup**

Both `nslookup` and `dig` are used to query DNS records to get domain name information.

#### **Using `nslookup`**:

```bash
nslookup google.com
```

#### **Using `dig`**:

```bash
dig google.com
```

Both commands will return detailed information about the DNS records of the domain.

#### **Example in a script**:

```bash
#!/bin/bash

DOMAIN="google.com"
nslookup $DOMAIN

if [ $? -eq 0 ]; then
    echo "DNS lookup for $DOMAIN succeeded"
else
    echo "DNS lookup for $DOMAIN failed"
fi
```

---

### **5. `traceroute` - Trace Route**

`traceroute` traces the path that your data takes to reach a remote host. It helps to identify where delays are happening in the network.

#### **Basic Usage**:

```bash
traceroute google.com
```

#### **Example in a script**:

```bash
#!/bin/bash

HOST="google.com"
traceroute $HOST
```

---

### **6. `curl` - Transfer Data from or to a Server**

`curl` is a command-line tool used to send HTTP requests and receive responses. It's often used to interact with web servers or APIs.

#### **Basic Usage**:

To make a simple HTTP GET request:

```bash
curl http://google.com
```

To download a file from a URL:

```bash
curl -O http://example.com/file.zip
```

To send a POST request with data:

```bash
curl -X POST -d "key=value" http://example.com
```

#### **Example in a script**:

```bash
#!/bin/bash

URL="http://example.com"
response=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$response" -eq 200 ]; then
    echo "Website is up"
else
    echo "Website is down, status code: $response"
fi
```

- `-s`: Silent mode (no progress or error messages).
- `-o /dev/null`: Discards the body of the response.
- `-w "%{http_code}"`: Outputs the HTTP status code.

---

### **7. `wget` - Download Files from the Web**

`wget` is used for downloading files over the network, supporting HTTP, HTTPS, and FTP protocols.

#### **Basic Usage**:

To download a file:

```bash
wget http://example.com/file.zip
```

To download a file in the background:

```bash
wget -b http://example.com/file.zip
```

#### **Example in a script**:

```bash
#!/bin/bash

URL="http://example.com/file.zip"
OUTPUT="/path/to/downloaded_file.zip"

# Download a file using wget
wget -O $OUTPUT $URL

if [ $? -eq 0 ]; then
    echo "File downloaded successfully"
else
    echo "Failed to download file"
fi
```

---

### **8. `ssh` - Secure Shell**

`ssh` is used to connect securely to remote machines over the network.

#### **Basic Usage**:

To connect to a remote server:

```bash
ssh username@hostname
```

To run a command on a remote server:

```bash
ssh username@hostname "command_to_run"
```

#### **Example in a script**:

```bash
#!/bin/bash

HOST="remote.server.com"
USER="user"
COMMAND="uptime"

# Run a command on a remote server
ssh $USER@$HOST $COMMAND
```

---

### **9. `scp` - Secure Copy**

`scp` allows you to securely copy files between local and remote systems over SSH.

#### **Basic Usage**:

To copy a file from local to remote:

```bash
scp /path/to/local/file username@remote:/path/to/remote/directory
```

To copy a file from remote to local:

```bash
scp username@remote:/path/to/remote/file /path/to/local/directory
```

#### **Example in a script**:

```bash
#!/bin/bash

LOCAL_FILE="/path/to/local/file.txt"
REMOTE_HOST="remote.server.com"
REMOTE_DIR="/path/to/remote/directory"
USER="user"

# Copy a file to remote server
scp $LOCAL_FILE $USER@$REMOTE_HOST:$REMOTE_DIR
```

---

### **10. `iptables` - Manage Firewall Rules**

`iptables` is a tool for configuring the Linux kernel firewall. It allows you to filter and manage network traffic.

#### **Basic Usage**:

List current firewall rules:

```bash
sudo iptables -L
```

Allow incoming HTTP traffic:

```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

Block an IP address:

```bash
sudo iptables -A INPUT -s 192.168.1.100 -j DROP
```

#### **Example in a script**:

```bash
#!/bin/bash

# Allow incoming HTTP traffic
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Block an IP address
sudo iptables -A INPUT -s 192.168.1.100 -j DROP
```

---

### **11. `hostname` - Get or Set System's Hostname**

`hostname` is used to display or set the system's hostname.

#### **Basic Usage**:

To display the current hostname:

```bash
hostname
```

To set a new hostname:

```bash
sudo hostname new-hostname
```

#### **Example in a script**:

```bash
#!/bin/bash

NEW_HOSTNAME="myserver"
sudo hostname $NEW_HOSTNAME
echo "Hostname has been changed to $NEW_HOSTNAME"
```

---

### **Summary of Networking Commands:**

1. **ping**: Test connectivity to a host.
2. **ifconfig** / **ip**: Show and configure network interfaces.
3. **netstat**: View network connections and statistics.
4. **nslookup** / **dig**: DNS query tools.
5. **traceroute**: Trace the route packets take to a remote host.
6. **curl**: Transfer data to/from a server (supports HTTP, FTP, etc.).
7. **wget**: Download files from the web.
8. **ssh**: Secure remote access.
9. **scp**: Securely copy files between machines.
10. **iptables**: Configure firewall rules.
11. **hostname**: Display/set the system's hostname.

---

### **Next Steps:**

- Explore how you can combine networking commands in a script to automate common network tasks, like monitoring connectivity or running remote diagnostics.
- Use these commands to write scripts for tasks such as network troubleshooting or automated file downloads.
