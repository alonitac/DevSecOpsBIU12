#!/bin/bash
FILEPATH="/home/$USER/.token"
FILENAME=".token"
D_SHELL="zsh"

#greetings
echo "Hello $USER"
echo

#print packages updates
CHECK_UPDATES='/usr/lib/update-notifier/apt-check --human-readable'
echo $($CHECK_UPDATES)

# .token file permission check
if [ -f "$FILEPATH" ] && [ "$(stat -c "%a" $FILEPATH)" != "600" ]; then
    echo  "Warning: $FILENAME file has too open permissions"
fi

#add "environment" variable COURSE_ID no export
COURSE_ID='devsecope12'

#Set ZSH as default shell
#if [ ! -z $(which $D_SHELL) ]; then
#  chsh -s $D_SHELL
#fi

#exit program
exit 0