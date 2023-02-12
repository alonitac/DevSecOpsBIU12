# Session I (13/1)

### Covered content

- Welcome: [README.md](README.md)
- [bash/01_intro.md](bash/01_intro.md)
- [bash/02_bash-and-other-animals.md](bash/02_bash-and-other-animals.md)



### Mandatory for all students

- Complete the module onborading - install Git, Pycharm, create GitHub account.
- Do [exercise 1](ex1/)

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

### Covered content

- [bash/03_the-PATH.md](bash/03_the-PATH.md)
- [bash/04_processes.md](bash/04_processes.md)
- [bash/05_debugging.md](bash/05_debugging.md)
- [bash/07_bash-conf-files.md](bash/07_bash-conf-files.md)
 

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

# Session IV (24/1) + Session V (27/1)

### Covered content

- [bash/08_variables_deep_dive.md](bash/08_variables_deep_dive.md)
- [bash/09_conditional_statements.md](bash/09_conditional_statements.md)

### Mandatory for all students

- Complete the [exercise](bash/09_conditional_statements.md#exercise) we started in class.
- Review [string-comparisons](bash/09_conditional_statements.md#string-comparisons) and [if-grep-construct](bash/09_conditional_statements.md#if-grep-construct) sections.
- Do [exercise 2](ex2/)

### General terms and concepts to overview

- RESTful API: https://www.redhat.com/en/topics/api/what-is-a-rest-api
- HTTP Protocol overview: https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview
- Read some information about "hash tables", about md5 algorithm and try to use the `md5sum` command to has some text. 

### ShellCheck 

1. First, get familiar with the concept of Linting: - Linting: https://en.wikipedia.org/wiki/Lint_(software)

2. In this section we will use a Bash linter called ShellCheck to lint your `bash_ex1` solution. 

3. In the official GitHub page, you'll find the [installation guide](https://github.com/koalaman/shellcheck#installing) for many systems. Find your right installation command, and install ShellCheck. 

4. Read the [how to use](https://github.com/koalaman/shellcheck#from-your-terminal) section, invoke `shellcheck` from your terminal that lints your solution. Review the output. 

### Variable reference using curly braces `${}`

We've discussed in class regarding the use of curly braces `${}` when referencing a variable in Bash. Read the chapter on [Parameter Substitution](https://tldp.org/LDP/abs/html/parameter-substitution.html) to see more examples.
