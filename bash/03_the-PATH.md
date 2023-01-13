# The `$PATH`

When you want the system to execute a command, you almost never have to give the full path to that
command. For example, we know that the `ls` command is in the `/bin` directory (check with `which -a ls`),
yet we don't have to enter the command `/bin/ls` for the computer to list the content of the current directory.

The PATH environment variable takes care of this.

Normal programs are system commands that exist in compiled form on your system (e.g. `ls`, `mkdir` etc... use `which` command to determine the full path of each command file)

```shell
which ls
echo
echo $PATH
```

Let's create a shell program and add it to your $PATH

```shell
# Create a directory to be added to the PATH
mkdir -p ~/scripts

# Create your script in myscript file
echo """ 

#!/bin/bash
echo my script is running...

""" > myscript

echo "Testing the script using bash"
bash myscript

echo 

# Give it execute permissions
chmod u+x myscript

echo "Testing the script using direct execution"
./myscript

echo

# Copy your script into ~/scripts
cp myscript ~/scripts/myscript

# Add ~/scripts to the PATH
PATH=$PATH:~/scripts

echo "Testing the script as if it was a regulat command"

# Execute you script
myscript
```

Having written the script, you can invoke it:

- By `bash myscript`.
- Much more convenient is to make the script itself directly executable with a `chmod`:   
  `chmod u+x myscriot` or `chmod 555 myscript`.
  Then you may execute it by `./myscript`.

- Or you can add you script to a directory in the PATH as invoke it as a "regular" command

### Bash execution in terms of processes 

When a program is executed, a **new process** is created because Bash makes an exact copy of itself. **This child process has the same environment as its parent**, only the process ID
number is different. This procedure is called *forking*

