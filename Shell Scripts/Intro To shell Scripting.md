
### 1. **What is Shell Scripting?**
A **shell script** is a text file containing a series of commands for a Unix-based shell to execute. It can be used to automate repetitive tasks, manage system processes, and perform administrative tasks.

In Linux, the shell is the command-line interface where you interact with the system (e.g., `bash`, `sh`, `zsh`).

### 2. **Basic Shell Script Structure**

A simple shell script typically consists of:
- **Shebang (`#!/bin/bash`)**: This is the first line of the script and tells the system which interpreter to use to run the script. For bash scripts, it's `#!/bin/bash`.
- **Commands**: The commands inside the script are the ones that the shell will execute.
- **Comments (`#`)**: You can add comments to explain parts of the script. These are ignored during execution.

#### Example:
```bash
#!/bin/bash
# This is a simple shell script

echo "Hello, World!"  # Print a message to the terminal
```

### 3. **Basic Commands in Shell Scripting**

You will use common shell commands in your scripts, such as:

- **`echo`**: Used to print output to the terminal.
  ```bash
  echo "Hello, World!"
  ```

- **`ls`**: List files and directories.
  ```bash
  ls
  ```

- **`pwd`**: Show the current working directory.
  ```bash
  pwd
  ```

- **`cd`**: Change directories.
  ```bash
  cd /home/user
  ```

- **`mkdir`**: Create a directory.
  ```bash
  mkdir new_directory
  ```

- **`touch`**: Create a new empty file.
  ```bash
  touch newfile.txt
  ```

### 4. **Variables in Shell Scripting**

You can define variables to store values in shell scripts. Variables in bash don't require a type declaration, and you assign values without spaces around the `=` sign.

#### Example:
```bash
#!/bin/bash

name="John"
echo "Hello, $name!"
```

- **Note**: When referencing a variable, use the `$` symbol (e.g., `$name`).

### 5. **User Input in Shell Scripting**

You can ask users for input and store their responses in variables using the `read` command.

#### Example:
```bash
#!/bin/bash

echo "What is your name?"
read name  # Store user input in variable 'name'
echo "Hello, $name!"
```

### 6. **Control Structures: Conditional Statements**

You can make decisions in your script using **if-else** statements.

#### Example:
```bash
#!/bin/bash

echo "Enter a number: "
read number

if [ $number -gt 10 ]; then
    echo "The number is greater than 10."
else
    echo "The number is 10 or less."
fi
```

- **`-gt`** stands for "greater than". There are other operators like `-lt` (less than), `-eq` (equal), and `-ne` (not equal).

### 7. **Loops in Shell Scripting**

Shell scripts can use loops to repeat actions. The two most common types of loops are `for` and `while`.

#### For Loop:
```bash
#!/bin/bash

for i in {1..5}; do
    echo "Iteration $i"
done
```

- This will print numbers from 1 to 5.

#### While Loop:
```bash
#!/bin/bash

count=1
while [ $count -le 5 ]; do
    echo "Count is $count"
    ((count++))  # Increment the counter
done
```

- This will also print numbers from 1 to 5, but uses a while loop instead.

### 8. **Functions in Shell Scripting**

You can define functions to make your code more reusable and organized.

#### Example:
```bash
#!/bin/bash

# Define a function
greet() {
    echo "Hello, $1!"
}

# Call the function with an argument
greet "Alice"
```

- `$1` refers to the first argument passed to the function (in this case, "Alice").

### 9. **Working with Files in Shell Scripts**

You can perform operations on files like reading, writing, and checking if they exist.

#### Check if a file exists:
```bash
#!/bin/bash

if [ -f "myfile.txt" ]; then
    echo "File exists!"
else
    echo "File does not exist!"
fi
```

#### Redirect Output to a File:
```bash
#!/bin/bash

echo "This is a test" > testfile.txt  # Overwrites the file
echo "This is another test" >> testfile.txt  # Appends to the file
```

### 10. **Error Handling in Shell Scripting**

You can check if a command executed successfully using `$?`, which stores the exit status of the last command.

- **`0` means success**.
- **Non-zero values indicate failure**.

#### Example:
```bash
#!/bin/bash

mkdir new_folder
if [ $? -eq 0 ]; then
    echo "Folder created successfully."
else
    echo "Failed to create folder."
fi
```

### 11. **Basic Shell Script Example**

Here's a full example script that asks for the user's name, prints a greeting, creates a directory, and handles errors:

```bash
#!/bin/bash

# Ask for the user's name
echo "What's your name?"
read name

# Greet the user
echo "Hello, $name!"

# Create a new directory
mkdir /home/$name || { echo "Failed to create directory"; exit 1; }

echo "Directory created for $name!"
```

### 12. **Making Your Script Executable**

To make a shell script executable, follow these steps:
1. Write your script and save it as `script.sh`.
2. Make the script executable:
   ```bash
   chmod +x script.sh
   ```
3. Run the script:
   ```bash
   ./script.sh
   ```

### 13. **Best Practices**
- Always include the shebang `#!/bin/bash` at the top of your scripts.
- Comment your code to make it easier to understand.
- Use proper indentation to make the script readable.
- Handle errors using `if` statements or checking the exit status of commands.

---

