# Debugging scripts

## Using `echo`

Using the "echo" command in bash scripts is a useful debugging tool. It allows you to print output to the terminal, which can help you understand the flow of the script and identify errors. By adding "echo" statements in strategic places, you can observe the values of variables and see how the script is executing.

## Using `bash -x`

Bash provides extensive debugging features. The most common is to start up the subshell with the `-x` option, which
will run the entire script in debug mode.

Execute the following script by `bash -x myscript.sh`:

```shell
echo "hi"
cd /var/lib/kafka
```

#### Debugging on part(s) of the script

Using the set Bash built-in you can run in normal mode those portions of the script of which you are sure they
are without fault, and display debugging information only for troublesome zones.

```shell
set -x  # activate debugging from here
w
set +x  # stop debugging from here
```

