## Bash scripting    

### Why Bash?

- Make life easier on UNIX or UNIX-like system
- Ease execution of daily tasks
- Automate important operation task

The UNIX shell program interprets user commands to the kernel, which are either directly entered by the user, or which can be read from a file called the **shell script**. Apart from passing commands to the kernel, the main task of a shell is providing a **user environment**, which can be configured individually using shell resource configuration files.

### An example Bash program


A script to clean up log files (messages, wtmp) in /var/log

Copy and execute the following snippet to a `.sh` file in your local Linux machine.

```shell
# Run as root, of course.
cd /var/log
cat /dev/null > messages
cat /dev/null > wtmp
echo "Log files cleaned up."
```

There is nothing unusual here, only a set of commands that could just as easily have been invoked one by one. Is this a script? maybe...Is this a program? not yet...

Let's try again...

```shell
# Proper header for a Bash script.
#!/bin/bash

# Run as root, of course.
LOG_DIR=/var/log   # Variables are better than hard-coded values.

cd $LOG_DIR
cat /dev/null > messages
cat /dev/null > wtmp
echo "Logs cleaned up."

exit # The right and proper method of "exiting" from a script.
# A bare "exit" (no parameter) returns the exit status of the preceding command.
```

Now that's beginning to look like a real script. But we can go even farther...

The following script uses quite a number of features that will be explained later on.  

```shell
#!/bin/bash
LOG_DIR=/var/log
ROOT_UID=0     # Only users with $UID 0 have root privileges.
LINES=50       # Default number of lines saved.

E_XCD=86       # Can't change directory?
E_NOTROOT=87   # Non-root exit error.


# Run as root, of course.
if [ "$UID" -ne "$ROOT_UID" ]
then
  echo "Must be root to run this script."
  exit $E_NOTROOT
fi

if [ -n "$1" ]  # Test whether command-line argument is present (non-empty).
then
  lines=$1
else
  lines=$LINES  # Default, if not specified on command-line.
fi

cd $LOG_DIR
if [ `pwd` != "$LOG_DIR" ] # or if [ "$PWD" != "$LOG_DIR" ]
                           # Not in /var/log?
then
  echo "Can't change to $LOG_DIR."
  exit $E_XCD
fi # Doublecheck if in right directory before messing with log file.


tail -n $lines messages > mesg.temp  # Save last section of message log file.
mv mesg.temp messages                # Rename it as system log file.
cat /dev/null > wtmp

echo "Log files cleaned up."
exit 0
```
