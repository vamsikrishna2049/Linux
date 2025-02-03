### Mount the Volume

Attaching the volume to the Existing VM machine in AWS Cloud platform

```bash
ubuntu@jenkins:~$ lsblk
NAME     MAJ:MIN   RM  SIZE RO TYPE MOUNTPOINTS
loop0      7:0      0 26.3M  1 loop /snap/amazon-ssm-agent/9881
loop1      7:1      0 73.9M  1 loop /snap/core22/1722
loop2      7:2      0 44.4M  1 loop /snap/snapd/23545
xvda     202:0      0    8G  0 disk
├─xvda1  202:1      0    7G  0 part /
├─xvda14 202:14     0    4M  0 part
├─xvda15 202:15     0  106M  0 part /boot/efi
└─xvda16 259:0      0  913M  0 part /boot
xvdbb    202:13568  0   10G  0 disk
ubuntu@jenkins:~$
```

To mount the `xvdbb` volume (which is 10GB in size), follow these steps:

### 1. **Create a Filesystem on the Disk**  
Since the disk (`/dev/xvdbb`) is currently unformatted, you'll need to create a filesystem on it. Let's use `ext4` for this example. You can replace `ext4` with any other filesystem type if needed.

```bash
sudo mkfs.ext4 /dev/xvdbb
```

### 2. **Create a Mount Point**  
Create a directory where you will mount the new volume. For example, create a directory called `/mnt/data`:

```bash
sudo mkdir /mnt/data
```

### 3. **Mount the Disk**  
Now, mount the disk to the newly created mount point.

```bash
sudo mount /dev/xvdbb /mnt/data
```

### 4. **Verify the Mount**  
Check if the volume is properly mounted by using the `df` command.

```bash
df -h
```

You should see `/mnt/data` listed as a mounted file system with a size of 10GB.

### 5. **Make the Mount Permanent**  
To ensure the volume is automatically mounted on system reboot, you'll need to add an entry to the `/etc/fstab` file.

First, get the UUID of the disk:

```bash
sudo blkid /dev/xvdbb
```

It will give you an output like this:

```
/dev/xvdbb: UUID="xxxx-xxxx" TYPE="ext4"
```

Now, edit the `/etc/fstab` file to add this UUID for auto-mounting.

```bash
sudo nano /etc/fstab
```

Add the following line to the file (replace `xxxx-xxxx` with the actual UUID you got from `blkid`):

```
UUID=xxxx-xxxx /mnt/data ext4 defaults 0 0
```

Save and exit the editor (in `nano`, press `Ctrl + X`, then `Y`, and `Enter`).

### 6. **Test the Mount**  
To verify that the disk mounts correctly after a reboot, you can unmount it and then remount it using `fstab`.

```bash
sudo umount /mnt/data
```

Note:
If no errors occur, the disk is successfully mounted and will mount automatically after a reboot.

### 7. **Reload the systemd manager:**  
```bash
sudo systemctl daemon-reload
```

### 8. **mounting the filesystem**
```bash
sudo mount -a
```
mount: (hint) your fstab has been modified, but systemd still uses
       the old version; use 'systemctl daemon-reload' to reload.

### 9. **Verify Mount is successful**
```bash
df -h
```

This should show that your /mnt/data directory is now properly mounted.
