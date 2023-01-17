# Shell types

- **sh** or Bourne Shell: the original shell still used on UNIX systems
- **bash** or Bourne Again shell: the standard GNU shell, intuitive and flexible. Probably most advisable
  for beginning users while being at the same time a powerful tool for the advanced and professional
  user. On Linux, bash is the standard shell for common users.


The file `/etc/shells` gives an overview of known shells on a Linux system:

```shell
cat /etc/shells
```

An example of a shell called "Restricted Bash": 

```shell
rbash     # this command creates a new terminal session of restricted bash which may be looked exactly like bash terminal 
cd /var
```

Your default shell is set in the `/etc/passwd` file for each user.

```shell
# to know your current Linux user, echo the following environment variable
echo $USER
cat /etc/passwd | grep $USER
```

### Which shell should run the script?

When running a script in a subshell, you should define which shell should run the script. The shell type in
which you wrote the script might not be the default on your system, so commands you entered might result in
errors when executed by the wrong shell.


The sha-bang (#!) at the head of a script tells your system that this file is a set of commands to be fed to
the command interpreter indicated.

Note that the path given at the "sha-bang" must be correct, otherwise an error message -- usually "Command
not found." -- will be the only result of running the script.

Copy and execute the following snippet to a `.sh` file in your local Linux machine.


```shell
#!/bin/bash
ls
cd /var
```



