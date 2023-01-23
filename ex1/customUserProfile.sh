#!/bin/bash

APTPATH="/usr/lib/update-notifier"
USERHOME=$HOME
FILE=".token"

#greetings
echo -e "hello $USERNAME \n"

#print
echo -e "$($APTPATH/apt-check --human-readable) \n"

# .token file permission check
if [[ -f $USERHOME/$FILE ]]; then
	if [ '$(stat -c "%a" $USERHOME/$FILE)' > 600 ]; then
		echo "Warning: $FILE has too open permissions"
	fi
fi

#Set Environment variable COURSE_ID >> devsecops12
COURSE_ID='devsecops12'

#Set ZSH as default shell

#exit program
exit 0