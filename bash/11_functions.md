# Functions

Shell functions are a way to group commands for later execution, using a single name for this group. The name of the routine must be unique within the shell or script. A function is executed within the shell in which
it has been declared: no new process is created to interpret the commands.



Functions either use the syntax

`function FUNCTION { COMMANDS; }`

or

`FUNCTION () { COMMANDS; }`

Both define a shell function FUNCTION. The use of the built-in command function is optional; however, if
it is not used, parentheses are needed.

The commands listed between curly braces make up the body of the function. These commands are executed
whenever FUNCTION is specified as the name of a command. The exit status is the exit status of the last
command executed in the body.

Let's start with a very simple function - a function that prints "hi":

```shell
# define the function
function greeting {
  echo "Hi"  
}

# execute the function 
greeting
```

Copy the above snippet to a `.sh` script and execute.

We want now to send an argument to the function, in the same way we pass arguments to bash scripts:

```shell
# define the function
function greeting {
  echo "Hi, $1"  
}

# execute the function 
greeting John
```

To execute the function `greeting` from another bash file, use the `source` command to "import" the function:

myscript-1.sh:

```shell
# myscript-1.sh 

function greeting {
  echo "Hi, $1"  
}
```

myscript-2.sh:

```shell
# myscript-2.sh

source myscript-1.sh

greeting John
```
 
---

Here is more complex example:

```shell
function log {
  local level="$1"
  local message="$2"
  local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  local script_name="$(basename "$0")"
  echo -e "${timestamp} [${level}] [$script_name] ${message}"
}

function log_info {
  log "INFO" "$1"
}

function log_err {
  log "ERROR" "$1"
}

function log_warn {
  log "WARN" "$1"
}

function log_debug {
  log "DEBUG" "$1"
}
```

```shell
function os_user_exists {
  id "$1" &> /dev/null
}

function os_create_user {
  local -r username="$1"    # -r stands for raed-only variable
  local -r with_sudo="$2"
  
  local exuseradd='useradd'
  if [[ "$with_sudo" == 'true' ]]; then
    exuseradd='sudo useradd'
  fi

  if os_user_exists "$username"; then
    echo "User $username already exists. Will not create again."
    RETURN_VALUE=1
  else
    echo "Creating user named $username"
    $exuseradd "$username"
    RETURN_VALUE=0
  fi
}

os_create_user john true
echo "function return value: $RETURN_VALUE"
echo
cat /etc/passwd
```

When a function is executed, the arguments to the function become the positional parameters during its
execution. The special parameter # that expands to the number of positional parameters is updated to reflect
the change. Positional parameter 0 is unchanged. The Bash variable FUNCNAME is set to the name of the
function, while it is executing.

## Try it yourself

```shell

# Returns true (0) if the first string contains the second
# string, and false (1) otherwise.
function string_contains {

}


# Return true if the given response is empty or "null" (the latter is from jq parsing).
function string_is_empty_or_null {
  
}


# Given a string $str, return the substring beginning at index $start and ending at index $end.
# Use ${str:4:10} to the get substring of $str from index 4 to 10
# Example:
#
# string_substr "hello world" 0 5
#   Returns "hello"
function string_substr {

}


# Change the owner of $1 to $2. If true is passed in as the last arg ($3), run the command with sudo.
# Recall chown user:group file
function os_change_file_owner {
  local -r dir="$1"
  local -r username="$2"
  local -r with_sudo="$3"


}

# Use os_change_file_owner and list the files in dir $1 and change the ownership of each file
function os_change_dir_owner {
  local -r dir="$1"
  local -r username="$2"
  local -r with_sudo="$3"


}


# Prints the type if the given file in the given order: regular, directory, readable, writable, executable
function file_type {
  local -r file="$1"

}

# Creates files in the form <prefix>-<index>.<extension> while prefix is $1 index is a running integer from 1 to $2 and extension is $3 
function files_gen {


}


# Returns the $1'th line of a file 
function get_line {


}

```