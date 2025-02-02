The `sed` (stream editor) command in Linux is incredibly powerful for text processing and manipulation. Here are some useful `sed` commands and examples to help you understand its syntax and common uses.

### General `sed` Syntax:

```bash
sed [options] 'command' file
```

- `options`: Optional flags like `-n` for suppressing automatic output or `-e` for multiple expressions.
- `'command'`: The command to be executed. Common ones include `s` for substitution, `d` for delete, and `p` for print.
- `file`: The input file where `sed` reads text from.

### Examples of `sed` Commands:

#### 1. **Substitution (s)**
   - **Replace every occurrence of "Linux" or "linux" with "RHEL"**:
     ```bash
     sed 's/Linux|linux/RHEL/g' report.txt
     ```
     - This replaces all instances of `Linux` or `linux` with `RHEL`.

   - **Replace the first instance of "foo" with "bar" in a line**:
     ```bash
     sed 's/foo/bar/' file.txt
     ```

   - **Replace "foo" with "bar" globally in a line**:
     ```bash
     sed 's/foo/bar/g' file.txt
     ```

   - **Replace the 4th occurrence of "foo" with "bar"**:
     ```bash
     sed 's/foo/bar/4' file.txt
     ```

   - **Case-insensitive replacement**:
     ```bash
     echo ONE TWO | sed "s/one/unos/I"
     ```
     - This changes `one` to `unos` case-insensitively.

#### 2. **Delete (d)**
   - **Delete the last line**:
     ```bash
     sed '$d' file.txt
     ```

   - **Delete all lines from line 17 to the first occurrence of "disk"**:
     ```bash
     sed '17,/disk/d' file.txt
     ```

   - **Delete lines matching a pattern**:
     ```bash
     sed '/pattern/d' file.txt
     ```

   - **Delete blank lines**:
     ```bash
     sed '/^$/d' file.txt
     ```

#### 3. **Print (p)**
   - **Print only lines containing "Linux"**:
     ```bash
     sed -n '/Linux/p' file.txt
     ```

   - **Print lines 12 through 18 of the file**:
     ```bash
     sed -n '12,18p' file.txt
     ```

   - **Print the first match of a pattern**:
     ```bash
     sed -n '/RE/{p;q;}' file.txt
     ```

#### 4. **Insert (i)**
   - **Insert a line before a match**:
     ```bash
     sed '/pattern/i\New Line Text' file.txt
     ```

   - **Insert a line after a match**:
     ```bash
     sed '/pattern/a\New Line Text' file.txt
     ```

#### 5. **Appending (A)**
   - **Double-space a file**:
     ```bash
     sed G file.txt
     ```

   - **Triple-space a file**:
     ```bash
     sed 'G;G' file.txt
     ```

#### 6. **Regular Expressions**
   - **Match lines containing exactly three digits**:
     ```bash
     sed '/[0-9]\{3\}/p' file.txt
     ```

   - **Print paragraphs containing regex**:
     ```bash
     sed '/./{H;$!d;};x;/regex/!d' file.txt
     ```

   - **Print the line before and after the line matching regex**:
     ```bash
     sed -n '/regexp/{x;p;x;}' file.txt
     ```

#### 7. **Join Lines**
   - **Join lines if a file ends with a backslash**:
     ```bash
     sed ':a; s/\\n//; ta' file.txt
     ```

   - **Join two lines if the first line ends with a backslash**:
     ```bash
     sed ':a; s/\\n//; ta' file.txt
     ```

#### 8. **Working with CSV Files**
   - **Change the first field in a CSV file to 9999**:
     ```bash
     sed 's/^[^,]*,/9999,/' file.csv
     ```

   - **Convert CSV file to a pipe-separated file**:
     ```bash
     s/^ *\(.*[^ ]\) *$/||/;
     s/" *, */"|/g;
     : loop
     s/| *\([^",|][^,|]*\) *, */||/g;
     s/| *, */||/g;
     t loop
     s/ *|/|/g;
     s/| */|/g;
     s/^|\(.*\)|$//;
     ```

#### 9. **Advanced Replacements**
   - **Convert words starting with "reg" or "exp" to uppercase**:
     ```bash
     sed -r "s/\<(reg|exp)[a-z]+/\U&/g"
     ```

   - **Replace text only in a range of lines** (e.g., replace "RHELson" with "White" between lines 1 and 20):
     ```bash
     sed '1,20 s/RHELson/White/g' file.txt
     ```

   - **Match lines between two patterns**:
     ```bash
     sed '/from/,/until/ { s/\<red\>/magenta/g; s/\<blue\>/cyan/g; }' file.txt
     ```

   - **Delete trailing blank lines**:
     ```bash
     sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' file.txt
     ```

#### 10. **Number Lines**
   - **Number lines in a file**:
     ```bash
     sed = file.txt | sed 'N;s/\n/\t/'
     ```

#### 11. **Sorting Paragraphs**
   - **Sort paragraphs in a file alphabetically**:
     ```bash
     sed '/./{H;d;};x;s/\n/={NL}=/g' file.txt | sort | sed '1s/={NL}=//;s/={NL}=/\n/g'
     ```

#### 12. **Handling Paths**
   - **Replace `/usr/bin` with `/usr/bin/local`**:
     ```bash
     sed 's@/usr/bin@&/local@g' path.txt
     ```

   - **Remove all characters from "a" to "g"**:
     ```bash
     sed 's/[a-g]//g' file.txt
     ```

### Key `sed` Options:
- `-n`: Suppress automatic printing of lines. Useful with `p` to explicitly print lines.
- `-e`: Allows multiple expressions.
- `-f`: Executes commands from a file (script).
- `-r`: Enable extended regular expressions (for more complex patterns).
