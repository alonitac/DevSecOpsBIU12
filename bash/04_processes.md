# Bash execution in terms of processes 

When a program is executed, a **new process** is created because Bash makes an exact copy of itself. **This child process has the same environment as its parent**, only the process ID
number is different. This procedure is called *forking*

```shell
echo $$  # the $ is a special variable containing the process id of the shell terminal

# We use here single qoute ' 
# Variable referencing disabled (escaped) by single quotes!!!
echo 'echo Current process ID is $$' > myscript

# What are the differences between > and >> io operators? 
echo "pstree" >> myscript

# run the program by:
bash myscript

# check that the last command has been completed successfully
# "0" indicating success, any other number indicating failure
echo $?
```

In the above output we can see that PID of the parent bash is different from the child process (the program myscript). We can also notice in the output of `pstree`:
```text
bash---bash---pstree
```
Indicating that there are two different processes of bash.

While the subshell processes each line of the script, the parent shell waits for its child process to finish. When
there are no more lines in the shell script to read, the subshell terminates. The parent shell awakes and
displays a new prompt.

If you don't want to start a new shell but execute the script in the current shell process, you should `source` it:

```shell
echo $$
echo 'echo Current process ID is $$' > myscript
echo "pstree" >> myscript
source myscript
```

