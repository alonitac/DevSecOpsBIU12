# Variables
Variables are how programming and scripting languages represent data. A variable is nothing more than a label, a name assigned to a location or set of locations in computer memory holding an item of data.
As seen in the examples above, shell variables are in uppercase characters by convention.

Let us carefully distinguish between the name of a variable and its value. If variable1 is the name
of a variable, then $variable1 is a reference to its value, the data item it contains.


```shell
variable1=23

echo variable1
echo $variable1
```

No space permitted on either side of = sign when initializing variables. What happens if there is a space?

```shell
VARIABLE =value
VARIABLE= value
VARIABLE = value
```

## Referencing a variable

```shell
a=375
hello=$a

echo hello      # hello
echo $hello     # 375
echo ${hello}   # 375
echo "$hello"   # 375
echo "${hello}" # 375

echo
echo

hello="A B   C     D"       # If there is whitespace embedded within a variable, then quotes are necessary.
echo $hello     # A B C D


# Quoting a variable preserves whitespace.
echo "$hello"   # A B   C     D 

# Variable referencing disabled (escaped) by single quotes
echo '$hello' # $hello
```

## Uninitialized variable
An uninitialized variable has a "null" value -- no assigned value at all (not zero!)

```shell
if [ -z "$unassigned" ]
then
  echo "\$unassigned is NULL."
fi
```

More... 

```shell
hello=  # Setting it to a null value.
```

Some times a variable appears "naked" -- without the $ prefix  
Examples given below:

```shell
# In a for loop
for var2 in 1 2 3
do
  echo $var2
done


# In an arithmetic expression
a=1
b=2

((c=a+b))
echo $c


# When read an input (to be trying in a real Linux terminal, not from the notebook) 
read var1
echo "var1 = $var1" 

```

## Variable Assignment

```shell
# Assignment
a=879
echo "The value of \"a\" is $a."
```

```shell
# Assignment using 'let'
let a=16+5
echo "The value of \"a\" is now $a."
```

Variable assignment using the $(...) mechanism

```shell
R=$(cat /etc/pip.conf)
arch=$(uname -m)

echo $arch
```

#### Bash Variables Are Untyped

Unlike many other programming languages, Bash does not segregate its variables by "type." Essentially, Bash
variables are character strings, but, depending on context, Bash permits arithmetic operations and
comparisons on variables. The determining factor is whether the value of a variable contains only digits.

## Environment variables

Global variables or **environment variables** are available in all shells. The **env** or **printenv** commands can be
used to display environment variables. These programs come with the *sh-utils* package.

Global variables are being transferred from parent process to child process. 

## Special bash variables

`$@` - Expands to the positional parameters, starting from one.

`$#` - Expands to the number of positional parameters in decimal.

`$?` - Expands to the exit status of the most recently executed foreground pipeline.

`$$` - Expands to the process ID of the shell.

`$0` - Expands to the name of the shell or shell script.



## Script positional variables 

Positional variables (or arguments) passed to the script from the command line: $0, $1, $2, $3 . . .

$0 is the name of the script itself, $1 is the first argument, $2 the second, $3 the third, and so forth.
After $9, the arguments must be enclosed in brackets, for example, ${10}, ${11}, ${12}.

Let's see them in action... create a file called `positional.sh` as follows:

```shell
#!/bin/bash

# This script reads 3 positional parameters and prints them out.

echo "$0 invoked with the following erguments: $@"

POSPAR1="$1"
POSPAR2="$2"
POSPAR3="$3"

echo "$1 is the first positional parameter, \$1."
echo "$2 is the second positional parameter, \$2."
echo "$3 is the third positional parameter, \$3."
echo
echo "The total number of positional parameters is $#."

if [ -n "${10}" ]               # Parameters > $9 must be enclosed in {brackets}.
then
  echo "Parameter #10 is ${10}"
fi

```

Execute the script by: 

```shell
bash positional.sh Yes We Can 
bash positional.sh Yes We Can Barack Obama
```

