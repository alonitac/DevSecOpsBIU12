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

# check that the last command has been completed successfully using the "?" variable.
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

## The `export` command

So far we've seen that each process has an "environment", that is, a group of variables that the process may reference.
Every time a shell starts, it creates shell variables that correspond to its own
environmental variables. 
Updating or adding new environmental variables causes the
shell to update its environment, and all the shell's child processes (the commands it
executes) inherit this environment.

If you want to set environmental variables for you bash script, those variables need to be "exported," that is, reported to the
environment local to your script. This is the function of the `export` command.

> Bash can export variables only to child processes, that is, only to commands or
> processes which that particular bash session initiates. A script invoked from the
> command-line cannot export variables back to the command-line environment.
> Child processes cannot export variables back to the parent processes that spawned them.

Here is an example for the usage of `export`.

Create the following bash script under `myscript.sh`:

```shell
# myscript.sh
echo "connecting to database: $DB_HOST"
```

Now execute the following commands in a new terminal:

```text
>> cat myscript.sh
echo "connecting to database: $DB_HOST"

>> DB_HOST=mysql-server.com
>> bash myscript.sh
connecting to database:
```

As can be seen, nothing has printed in the place of `$DB_HOST`, this because `myscript.sh` (which runs as a child process) doesn't have access to `DB_HOST` variable, as it's defined in its parent environment.

Let's export the variable to the child's process env:

```text
>> export DB_HOST=mysql-server.com
>> bash myscript.sh
connecting to database: mysql-server.com
```

## The `source` command

If you don't want to start a new shell but execute the script in the current shell process, you should `source` it.
The below example assumes your current bash session has access to a very sensitive variable, `DB_SECRET`.
You want to execute a script, `myscript2.sh`, which depends on the content of `DB_SECRET` from one hand, from the other hand, you are not willing to send `DB_SECRET` neither as an environment variable nor as a script argument. 

```shell
# myscript2.sh
echo "the current PID is $$"
echo "connecting to database: $DB_HOST, using the password: $DB_SECRET"
```

We use the command `source` to execute `myscript2.sh` in the same process as you current bash session: 

```text
>> echo "the current PID is $$"
123
>> DB_HOST=mysql-server.com
>> DB_SECRET=db_password_payload
>> source myscript2.sh
the current PID is 123
connecting to database: mysql-server.com, using the password: db_password_payload
```


