
### 1. **Hello World Script**
Create a script that outputs "Hello, World!" to the terminal.

**script.sh**:
```bash
#!/bin/bash
echo "Hello, World!"
```
- Save this script as `script.sh`.
- Make it executable with `chmod +x script.sh`.
- Run it with `./script.sh`.

### 2. **Reading User Input**
Create a script that asks for the user's name and greets them.

**script.sh**:
```bash
#!/bin/bash
echo "What's your name?"
read name
echo "Hello, $name!"
```

### 3. **Variable Assignment and Output**
Create a script that defines a variable and uses it in a message.

**script.sh**:
```bash
#!/bin/bash
greeting="Hello, everyone!"
echo $greeting
```

### 4. **Perform Basic Arithmetic**
Write a script that performs simple arithmetic calculations.

**script.sh**:
```bash
#!/bin/bash
num1=10
num2=5
sum=$((num1 + num2))
echo "The sum of $num1 and $num2 is $sum."
```

### 5. **File Operations: Create and List Files**
Write a script to create a file, check if it exists, and then list the contents of the directory.

**script.sh**:
```bash
#!/bin/bash
touch myfile.txt  # Create an empty file
if [ -f myfile.txt ]; then
    echo "File created successfully!"
else
    echo "File creation failed!"
fi

echo "Listing the files in the current directory:"
ls
```

### 6. **Check If a File or Directory Exists**
Write a script that checks if a given file or directory exists and prints a message.

**script.sh**:
```bash
#!/bin/bash
echo "Enter a filename or directory:"
read file

if [ -e "$file" ]; then
    echo "$file exists."
else
    echo "$file does not exist."
fi
```

### 7. **Looping Through Files**
Write a script to loop through all files in a directory and print their names.

**script.sh**:
```bash
#!/bin/bash
echo "Files in the current directory:"
for file in *; do
    echo "$file"
done
```

### 8. **Simple Conditional Statements**
Create a script that asks for the user's age and checks if they are eligible to vote (18 or older).

**script.sh**:
```bash
#!/bin/bash
echo "Enter your age:"
read age

if [ $age -ge 18 ]; then
    echo "You are eligible to vote!"
else
    echo "You are not eligible to vote yet."
fi
```

### 9. **Using `if-else` with File Permission Check**
Write a script that checks if a file has write permissions.

**script.sh**:
```bash
#!/bin/bash
echo "Enter a file name:"
read filename

if [ -w "$filename" ]; then
    echo "You have write permissions for $filename."
else
    echo "You do not have write permissions for $filename."
fi
```

### 10. **Redirecting Output to a File**
Create a script that outputs the list of running processes and saves it to a file.

**script.sh**:
```bash
#!/bin/bash
ps aux > processes.txt
echo "List of running processes has been saved to processes.txt"
```

### 11. **Using a While Loop to Count**
Write a script that uses a `while` loop to print numbers from 1 to 10.

**script.sh**:
```bash
#!/bin/bash
count=1
while [ $count -le 10 ]; do
    echo $count
    ((count++))
done
```

### 12. **Backup Script**
Write a script to back up a directory to a specific location.

**script.sh**:
```bash
#!/bin/bash
echo "Enter the directory to back up:"
read source_dir
echo "Enter the backup location:"
read backup_dir

cp -r "$source_dir" "$backup_dir"
echo "Backup of $source_dir completed to $backup_dir"
```

### 13. **Date and Time in Shell Script**
Create a script that displays the current date and time.

**script.sh**:
```bash
#!/bin/bash
echo "Current date and time: $(date)"
```

### 14. **User Authentication (Password Input)**
Write a script that asks the user to enter a password and checks if it matches a predefined password.

**script.sh**:
```bash
#!/bin/bash
password="secret123"

echo "Enter your password:"
read -s user_password  # The -s option hides the input

if [ "$user_password" == "$password" ]; then
    echo "Access granted!"
else
    echo "Incorrect password!"
fi
```

### 15. **Simple Backup Script with Timestamp**
Create a script that backs up a file and adds a timestamp to the backup file name.

**script.sh**:
```bash
#!/bin/bash
echo "Enter the file to back up:"
read source_file
timestamp=$(date +%Y%m%d_%H%M%S)
backup_file="${source_file}_backup_$timestamp"

cp "$source_file" "$backup_file"
echo "Backup created: $backup_file"
```

---

### How to Run the Scripts:
1. **Save the script** as `script.sh`.
2. **Make it executable**:
   ```bash
   chmod +x script.sh
   ```
3. **Run the script**:
   ```bash
   ./script.sh
   ```
