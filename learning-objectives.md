# Session I (13/1)

### Mandatory for all students

- Complete the module onborading - install Git, Pycharm, create GitHub account.

### General topics

- Waterfall model vs Agile
- Git vs GitHub
- Relative vs absolute Linux paths
- What are application logs? 

### Bash

- Get yourself to know how to work with some Terminal text editor (`nano`, `vi`). We will work in class with `nano`.
- Understand the Linux file permission [binary representation](https://en.wikipedia.org/wiki/File-system_permissions#Numeric_notation).

### Understanding `sudo`

Execute the following comamnds from your home (`~`) directory.

1. Create a new linux user in your system.
2. Use `sudo` to switch to the new created user (`-u` flag) and try to `mkdir` some new dir. 

What happened? did you succeed?  Why?

### Optional resources 

- Open source licenses https://choosealicense.com/
- The pre-commit Git tool https://pre-commit.com/

# Session II (17/1) + Session III (20/1)
 
### Terminate a script on error

Given a Bash script with multiple lines, Bash by default executes the commands one by one regardless the exit-code of each command (we've seen in class that even when command is failing, Bash continues to the next command). 
Sometimes, it's necessary to exit immediately on the first command failure.

Write some Bash program that intentionally contains some errors, execute the program first using `bash myscript.sh`, then with `bash -e myscript.sh`.

What `-e` does? 

### ' vs " in `echo`

Read the [following StackOverflow thread](https://stackoverflow.com/questions/6697753/difference-between-single-and-double-quotes-in-bash) discussed the differences between single and double quote in Bash. 

### io redirection

- Make sure you understand the difference between `>` and `>>`.
- Make sure you understand the role of `|` (our [book](https://tldp.org/LDP/abs/abs-guide.pdf) page 19).

### Restricted Bash (`rbash`)

Which of the following actions are not allowed in `rbash`?

  - Change the $PATH env var
  - Change $USER env var
  - `cd` to a directory
  - Redirect output to a file
  - Define a local variable

### Order of paths in $PATH

We've seen in class that the environment variable $PATH consists of list of path to binaries (usually `/usr/bin/`, `/usr/local/bin`, etc), separated by colons (`:`).
When given a command, the shell automatically searches on the directories listed in
the path for the executable. Normally, the system stores the $PATH definition in
`/etc/profile` and/or `~/.bashrc`

Open a new terminal session and validate that the order of the paths list is important - 
add two new paths of directories contain the same command (the same executable) and make sure that the command in the path appears first is executed. 


### Process forking 

Attached are some useful resources regarding process forking in Linux systems

- https://www.csl.mtu.edu/cs4411.ck/www/NOTES/process/fork/create.html
- https://www.youtube.com/watch?v=r16PoQCedUA