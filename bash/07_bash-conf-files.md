## System-wide configuration files

### The `/etc/profile` and `/etc/bash.bashrc` files

When invoked, Bash reads the `/etc/profile` instructions. These usually set the shell variables PATH, USER etc. All settings that you want to apply to all your users' environments should be in this file. On systems offering multiple types of shells, it might be better to put Bash-specific configurations in `/etc/bash.bashrc` file,
since `/etc/profile` is also read by other shells.

```shell
cat /etc/profile
```

```shell
cat /etc/bash.bashrc
```

### The `~/.bash*` file family
`.bash_profile` is the preferred configuration file for configuring user environments individually. In this file, users can
add extra configuration options or change default settings.

`.bash_history` contains user commands history

`.bash_logout` and `.bash_login` are executed by the command interpreter for logout, login shells.

`.bashrc` or `~/.profile` may also be used (In the absence of `~/.bash_profile` and `~/.bash_login`, `~/.profile` is read).


