# your solution here...

#!/bin/bash

#Greet the user
echo Hello $USER
echo

#Print how many packages are outdated
echo How many packages are outdated?
/usr/lib/update-notifier/apt-check --human-readable
echo

#Create .token file for
echo >> /home/$USER/.token > test
chmod 660 $HOME/.token

if [ "stat -c "%a" $HOME/.token" != '600' ]; then
        echo "Warning: .token file has too open permissions"
        exit 1;
fi

#Set environment variable
export COURSE_ID=devsecops12

#Define zsh as the default shell
chsh $(which zsh)

