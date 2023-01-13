## Debugging scripts
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

