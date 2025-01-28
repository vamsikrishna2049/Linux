
### 1. **Defining and Accessing Arrays**

In bash, arrays are **zero-indexed**, which means the first element has an index of `0`. You define arrays in a shell script as follows:

```bash
# Defining an array
my_array=("apple" "banana" "cherry" "date")

# Accessing array elements
echo ${my_array[0]}  # Outputs "apple"
echo ${my_array[1]}  # Outputs "banana"
```

### 2. **Getting All Elements of an Array**

To access all the elements of the array at once, use the `[@]` syntax:

```bash
# Accessing all elements of the array
echo ${my_array[@]}  # Outputs: apple banana cherry date
```

### 3. **Array Length**

You can get the **length** (number of elements) of the array using `${#array_name[@]}`:

```bash
# Getting the length of the array
array_length=${#my_array[@]}
echo "The array has $array_length elements."
```

**Output**:
```
The array has 4 elements.
```

### 4. **Adding Elements to an Array**

You can add elements to an array using the `+=` operator:

```bash
# Adding an element to the array
my_array+=("elderberry")

# Print all elements after adding
echo ${my_array[@]}  # Outputs: apple banana cherry date elderberry
```

### 5. **Iterating Over Array Elements**

You can use a **for loop** to iterate over the elements of an array:

```bash
#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date")

# Loop through the array
for fruit in "${fruits[@]}"; do
    echo $fruit
done
```

**Output**:
```
apple
banana
cherry
date
```

Alternatively, you can use a **for loop** with indices:

```bash
#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date")

# Loop through the array using indices
for i in "${!fruits[@]}"; do
    echo "Index $i: ${fruits[$i]}"
done
```

**Output**:
```
Index 0: apple
Index 1: banana
Index 2: cherry
Index 3: date
```

### 6. **Removing an Element from an Array**

To remove an element from an array, you can use `unset`:

```bash
#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date")

# Remove "banana" from the array
unset fruits[1]

# Print the array after removing
echo ${fruits[@]}  # Outputs: apple cherry date
```

### 7. **Multidimensional Arrays**

While bash does not support true multidimensional arrays, you can simulate them by using indexed arrays with values separated by spaces or other delimiters.

#### Example: Simulating a 2D array

```bash
#!/bin/bash

# Define a 2D array (array of arrays)
arr[0]="apple banana cherry"
arr[1]="dog cat mouse"

# Accessing elements
echo ${arr[0]}  # Outputs: apple banana cherry
echo ${arr[1]}  # Outputs: dog cat mouse
```

You can also use loops to simulate multidimensional arrays:

```bash
#!/bin/bash

# Define a 2D array using associative arrays (simulating rows and columns)
row1=("apple" "banana" "cherry")
row2=("dog" "cat" "mouse")

# Accessing elements
echo ${row1[0]}  # Outputs: apple
echo ${row2[2]}  # Outputs: mouse
```

### 8. **Array Operations: Searching and Modifying**

You can search through arrays or modify elements easily.

#### Searching for an element in an array:

```bash
#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date")

# Search for "banana"
if [[ " ${fruits[@]} " =~ " banana " ]]; then
    echo "Banana is in the array."
else
    echo "Banana is not in the array."
fi
```

**Output**:
```
Banana is in the array.
```

#### Modifying an element:

```bash
#!/bin/bash

# Define an array
fruits=("apple" "banana" "cherry" "date")

# Modify the second element
fruits[1]="blueberry"

# Print the modified array
echo ${fruits[@]}  # Outputs: apple blueberry cherry date
```

### 9. **Associative Arrays (Hash Maps)**

Bash also supports **associative arrays** (hash maps), which allow you to store key-value pairs. To use associative arrays, you need to declare the array type using `declare -A`.

#### Example of Associative Array:

```bash
#!/bin/bash

# Declare an associative array
declare -A fruits

# Add key-value pairs
fruits[apple]="red"
fruits[banana]="yellow"
fruits[cherry]="red"

# Access values using keys
echo "The color of apple is: ${fruits[apple]}"  # Outputs: red
echo "The color of banana is: ${fruits[banana]}"  # Outputs: yellow
```

#### Looping over Associative Arrays:

```bash
#!/bin/bash

# Declare an associative array
declare -A fruits
fruits[apple]="red"
fruits[banana]="yellow"
fruits[cherry]="red"

# Loop through the associative array
for fruit in "${!fruits[@]}"; do
    echo "$fruit is ${fruits[$fruit]}"
done
```

**Output**:
```
apple is red
banana is yellow
cherry is red
```

### 10. **Array Example: Calculating the Sum of an Array**

Here’s a simple script that sums up the elements of an array:

```bash
#!/bin/bash

# Define an array of numbers
numbers=(1 2 3 4 5)

# Initialize the sum to 0
sum=0

# Loop through the array and add each number to sum
for num in "${numbers[@]}"; do
    sum=$((sum + num))
done

echo "The sum of the array is: $sum"
```

**Output**:
```
The sum of the array is: 15
```

---

### Summary:

1. **Defining arrays**: Use parentheses to define an array: `array_name=("value1" "value2" "value3")`.
2. **Accessing array elements**: Use `${array_name[index]}`.
3. **Array length**: Use `${#array_name[@]}` to get the number of elements.
4. **Adding elements**: Use `array_name+=("new_value")`.
5. **Looping over arrays**: Use `for` loop to iterate over all elements or with indices.
6. **Removing elements**: Use `unset array_name[index]` to remove an element.
7. **Associative arrays**: Use `declare -A` for key-value pairs.

---

### Practice Task:
Write a script that:
1. Creates an array of 5 numbers.
2. Calculates the **average** of the numbers.
3. Prints the numbers, their sum, and the average.
