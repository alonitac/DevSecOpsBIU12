#!/bin/bash

CHECK_UPDATES="/usr/lib/update-notifier/apt-check --human-readable"
FILE=".token"
D_SHELL="zsh"

#greetings
echo "Hello $USER"

#print packages updates
echo -e "$($CHECK_UPDATES)"

# .token file permission check
if [ -e ~/$FILE ] && [ $(stat -c "%a" ~/$FILE) -ne 600 ]; then
		echo "Warning: $FILE file has too open permissions"
fi

#Set Environment variable COURSE_ID >> devsecops12
COURSE_ID='devsecops12'

#Set ZSH as default shell
if [ ! -z $(which $D_SHELL) ]; then
  chsh -s $D_SHELL
fi

#exit program
exit 0