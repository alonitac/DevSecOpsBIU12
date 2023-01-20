# your solution here...

#!/bin/bash

#Greet the user
echo Hello $USER

#Print how many packages are outdated
echo How many packages are outdated?
/usr/lib/update-notifier/apt-check --human-readable

#Check permission level
TOKEN_PATH=/home/$USER/.token
PERM="stat -c "%a" "$TOKEN_PATH""
if [[  -e "$TOKEN_PATH" ]]; then
  PERM=$(stat -c "%a" "$TOKEN_PATH")
  if [[ $PERM != '600' ]]; then
    echo Warning: .token file has too open permissions
  fi

#Set environment variable
COURSE_ID=devsecops12

#Define zsh as a  default shell
zsh
#chsh -s $(which zsh)
fi