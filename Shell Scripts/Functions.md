
### 1. **Basic Function Syntax**

The general syntax for defining a function in bash is:

```bash
function_name() {
    # Commands to be executed
    command1
    command2
    ...
}
```

You can call the function by simply using its name:

```bash
function_name
```

### 2. **Example of a Simple Function**

Here’s an example of a function that prints a greeting:

```bash
#!/bin/bash

# Define the function
greet() {
    echo "Hello, $1!"  # $1 is the first argument passed to the function
}

# Call the function
greet "Alice"
greet "Bob"
```

In this example:
- `greet()` is the function that takes one argument (`$1`).
- When you call the function, you pass `"Alice"` and `"Bob"` as arguments, and it prints the greeting for each.

**Output**:
```
Hello, Alice!
Hello, Bob!
```

### 3. **Function with Multiple Arguments**

You can pass multiple arguments to a function. The syntax to access arguments inside the function is `$1`, `$2`, `$3`, and so on.

```bash
#!/bin/bash

# Define the function
add_numbers() {
    sum=$(( $1 + $2 ))  # Adds the first and second arguments
    echo "The sum of $1 and $2 is $sum"
}

# Call the function with two arguments
add_numbers 3 5
```

**Output**:
```
The sum of 3 and 5 is 8
```

### 4. **Using Return Values**

In bash, functions can **return an exit status**, but they can’t return arbitrary values like in other programming languages. To return values from a function, we typically use **output redirection** or **global variables**.

#### Example using Output Redirection:

```bash
#!/bin/bash

# Define the function that returns a value
multiply_numbers() {
    result=$(( $1 * $2 ))  # Multiply the two numbers
    echo $result  # Return the result by echoing it
}

# Call the function and capture the result
result=$(multiply_numbers 4 6)

echo "The result is $result"
```

**Output**:
```
The result is 24
```

Here, `$(multiply_numbers 4 6)` captures the output of the function and assigns it to the `result` variable.

### 5. **Using Global Variables in Functions**

You can also manipulate global variables inside a function. By default, variables in a function are local to that function, but you can modify global variables if needed.

```bash
#!/bin/bash

# Global variable
global_var="I am a global variable"

# Define a function that modifies the global variable
modify_global() {
    global_var="I am modified by the function"
}

echo "Before function: $global_var"

# Call the function
modify_global

echo "After function: $global_var"
```

**Output**:
```
Before function: I am a global variable
After function: I am modified by the function
```

### 6. **Function with Default Arguments**

You can set default values for function arguments if no argument is passed.

```bash
#!/bin/bash

# Define the function with default value
greet() {
    name=${1:-"Guest"}  # If no argument is passed, use "Guest" as default
    echo "Hello, $name!"
}

# Call the function with and without an argument
greet "Alice"
greet
```

**Output**:
```
Hello, Alice!
Hello, Guest!
```

In this example, the function uses the default value `"Guest"` if no argument is provided.

### 7. **Function with Return Status**

You can return a status code from a function. In bash, a return value is an integer exit status, where `0` indicates success and any non-zero value indicates failure.

```bash
#!/bin/bash

# Define a function that checks if a file exists
check_file() {
    if [ -f "$1" ]; then
        echo "File exists!"
        return 0  # Success
    else
        echo "File does not exist!"
        return 1  # Failure
    fi
}

# Call the function and check the return status
check_file "/path/to/file"
status=$?

if [ $status -eq 0 ]; then
    echo "The operation was successful."
else
    echo "The operation failed."
fi
```

**Output** (depending on whether the file exists or not):
```
File does not exist!
The operation failed.
```

Here, `return 0` indicates the function was successful, and `return 1` indicates failure. You capture the return value using `$?`.

### 8. **Recursive Functions**

Bash functions can call themselves, which is called recursion. This is useful for tasks like calculating factorials or traversing directories.

```bash
#!/bin/bash

# Define a function to calculate factorial recursively
factorial() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local temp=$(($1 - 1))
        local temp_result=$(factorial $temp)  # Recursive call
        echo $(($1 * $temp_result))  # Multiply the current number by the result of the recursive call
    fi
}

# Call the factorial function
result=$(factorial 5)
echo "Factorial of 5 is: $result"
```

**Output**:
```
Factorial of 5 is: 120
```

### 9. **Function with Arguments and Return Values**

You can have functions that accept multiple arguments, perform calculations, and return results.

```bash
#!/bin/bash

# Function to calculate the area of a rectangle
area_of_rectangle() {
    local width=$1
    local height=$2
    local area=$((width * height))
    echo $area
}

# Call the function and store the result
area=$(area_of_rectangle 5 10)
echo "The area of the rectangle is: $area"
```

**Output**:
```
The area of the rectangle is: 50
```

---

### Summary of Key Points:

1. **Defining a function**:
   - `function_name() { ... }` or `function function_name { ... }`

2. **Accessing arguments**:
   - `$1`, `$2`, `$3`, ... for the first, second, third arguments.

3. **Returning values**:
   - Use `echo` to return values from a function.
   - Functions can return exit status using `return` (0 for success, non-zero for failure).

4. **Local variables**:
   - Variables inside a function are **local** by default unless declared global.

5. **Recursive functions**:
   - Functions can call themselves, often used for tasks like calculating factorials or traversing directories.

---

### Practice Exercise:
Try writing a script with the following requirements:
1. A function that takes two numbers as arguments and prints their sum.
2. A function that checks if a given directory exists, and if not, creates it.
3. Use these functions in the script and display the results.
