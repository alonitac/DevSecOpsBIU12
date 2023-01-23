#!/bin/bash

APTPATH="/usr/lib/update-notifier"
USERHOME=$HOME
FILE=".token"

#greetings
echo -e "hello $USERNAME \n"

#print
echo -e "$($APTPATH/apt-check --human-readable) \n"

# .token file permission check
if [[ ! -f $USERHOME/$FILE ]]; then
	exit
else
	if [ '$(stat -c "%a" $USERHOME/$FILE)' > 600 ]; then
		echo "Warning: $FILE has too open permissions"
		exit 0
	fi
fi

#exit program
exit 0