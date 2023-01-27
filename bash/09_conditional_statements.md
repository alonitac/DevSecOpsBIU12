# Conditional statements

At times you need to specify different courses of action to be taken in a shell script, depending on the success
or failure of a command. The if construction allows you to specify such conditions.
The most compact syntax of the if command is:

```
if TEST-COMMANDS; then CONSEQUENT-COMMANDS; fi
```

The TEST-COMMAND list is executed, and **if its return status is zero**, the CONSEQUENT-COMMANDS
list is executed. The return status is the exit status of the last command executed.

**Review the man page of `test` command**

Another form of the if statement may be:

```
if TEST-COMMANDS
then
  CONSEQUENT-COMMANDS
elif ANOTHER-TEST-COMMANDS
then
  CONSEQUENT-COMMANDS
else
  CONSEQUENT-COMMANDS
fi
```

### Testing files
The first example checks for the existence of a file:

```shell

echo "This scripts checks the existence of the messages file."
echo "Checking..."
if [ -f /var/log/messages ]
then
  echo "/var/log/messages exists."
fi
echo
echo "...done."
```

### Testing exit status

The ? variable holds the exit status of the previously executed command (the most recently completed
foreground process).

The following example utilize this variable to take a decision according to the success or failure of the previous command

```shell
curl google.com &> /dev/null

if [ $? -eq 0 ]
then
  echo "Request succeeed"
else
  echo "Request failed, trying again..."
fi
```

### Numeric comparisons

```shell
# num=$(wc -l /etc/passwd | awk '{ print $1 }')

num=$(wc -l /etc/passwd)

echo $num

if [ "$num" -gt "20" ]; then
  echo "Too many users in the system."
fi
```

### Exercise

Write a bash script (e.g. my-script.sh) that given an ip address, prints geo-location details, as follows:

* The script first checks if `jq` cli is installed, if not, it prints a message to the user with a link to download the tool: https://stedolan.github.io/jq/download/

* The script checks that **exactly one argument** was sent to it, which representing the ip address to check. Otherwise, an informative message is being printed to stdout.

* The script checks that the given IP argument is not equal to '127.0.0.1'

* The script performs an HTTP GET request to `http://ip-api.com/json/<ip>` while `<ip>` is the IP argument. The results should be stored in a variable.

* Using `jq` tool and the variable containing the HTTP response, check that the request has been succeeded by checking that `status` key has a value of `success`. The command `jq -r '.<key>'` can extract a key from the json (e.g. `echo $RESPONSE | jq -r '.status'`)

* If the request succeed, print the following information to the user:
    * country
    * city
    * regionName

### String comparisons

```shell
if [[ "$(whoami)" != 'root' ]]; then
  echo "You have no permission to run $0 as non-root user."
  exit 1;
fi
```

### if-grep construct

```shell
# The very useful "if-grep" construct:
# -----------------------------------

echo "Bash is ok" > file

if grep -q Bash file
then
  echo "File contains at least one occurrence of Bash."
fi
```

Another example

```shell
word=Linux
letter_sequence=inu
if echo "$word" | grep -q "$letter_sequence"
# The "-q" option to grep suppresses output.
then
  echo "$letter_sequence found in $word"
else
  echo "$letter_sequence not found in $word"
fi
```

> ### [] vs [[]]
> * With version 2.02, Bash introduced the [[ ... ]] extended test command, which performs comparisons
>  in a manner more familiar to programmers from other languages.
> * The [[ ]] construct is the more versatile Bash version of [ ]. This is the extended test command
> * Using the [[ ... ]] test construct, rather than [ ... ] can prevent many logic errors in scripts. For example, the
>  &&, ||, <, and > operators work within a [[ ]] test, despite giving an error within a [ ] construct
> * [[ prevents word splitting of variable values. So, if VAR="var with spaces", you
>  do not need to double quote $VAR in a test.
> * [[
>  can interpret strings to the right as glob patterns

