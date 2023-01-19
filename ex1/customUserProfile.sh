# your solution here...

#!/bin/bash
export COURSE_ID=devsecops12
chsh $(which zsh)

echo Hello $USER
echo

echo How many packages are outdated?
/usr/lib/update-notifier/apt-check --human-readable
echo

echo >> $HOME/.token > test
chmod 660 $HOME/.token

if [ "stat -c "%a" $HOME/.token" != '600' ]; then
        echo "Warning: .token file has too open permissions"
        exit 1;
fi
