# your solution here...

#!/bin/bash

#Greet the user
echo Hello $USER
echo

#Print how many packages are outdated
echo How many packages are outdated?
/usr/lib/update-notifier/apt-check --human-readable
echo

#Check permission level
if [ -e ~/.token ] ; then
 if [ "$(stat -c %a ~/.token)" != "600" ]   ; then
   echo "Warning: .token file has too open permissions"
fi

#Set environment variable
export COURSE_ID=devsecops12

#Define zsh as the default shell
chsh $(which zsh) $USER

