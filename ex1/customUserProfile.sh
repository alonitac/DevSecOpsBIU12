#!/bin/bash

# Variables Mpa
COURSE_ID=devsecops12
TOKEN_PARM=$(stat -c "%a" /home/$USER/.token)
TOKEN_PATH=/home/$USER/.token

# Greetings
echo "Hello $USER"
# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable

# Check the permissions of .token
if [[ -f $TOKEN_PATH ]]; then [[ $TOKEN_PARM ]]
    if [[ $TOKEN_PARM != 600 ]]; then
      echo "Warning: .token file has too open permissions"
    fi
    echo .token file perrmision is: "$TOKEN_PARM"
    echo Done check the permissions of .token
# Course variable
    echo "$COURSE_ID"
    echo Script done!
fi

echo Done!!!!!!!!!