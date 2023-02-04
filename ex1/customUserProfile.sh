#!/bin/bash

# VARIABLES
TOKEN_PARM=$(stat -c "%a" /home/"$USER"/.token)
TOKEN_PATH=/home/$USER/.token

# GREETINGS
echo "Hello $USER"

# PRINT HOW MANY PACKAGES ARE OUTDATED
/usr/lib/update-notifier/apt-check --human-readable

# CHECK IF .TOKEN EXIST AND ITS PERMISSIONS
if [[ -f $TOKEN_PATH ]]; then [[ $TOKEN_PARM ]]
    if [[ $TOKEN_PARM != 600 ]]; then
      echo "Warning: .token file has too open permissions"
    fi
fi

# COURSE VARIABLE
COURSE_ID='devsecops12'

# END OF EX1