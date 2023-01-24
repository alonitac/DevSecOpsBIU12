#!/bin/bash

CHECK_UPDATES="/usr/lib/update-notifier/apt-check --human-readable)"
TOKEN=".token"
D_SHELL="zsh"
PERM_MOD=600

#greetings
echo -e "Hello $USER"

#print packages updates
echo -e "$($CHECK_UPDATES)"

# .token file permission check
if [[ -f $HOME/$TOKEN ]]; then
	if [ "$(stat -c "%a" $HOME/$TOKEN)" -ne $PERM_MOD  ]; then
		echo "Warning: $TOKEN file has too open permissions"
	fi
fi

#Set Environment variable COURSE_ID >> devsecops12
COURSE_ID='devsecops12'

#Set ZSH as default shell
if [ ! -z $(which $D_SHELL) ]; then
  chsh -s $D_SHELL
fi

#exit program
exit 0