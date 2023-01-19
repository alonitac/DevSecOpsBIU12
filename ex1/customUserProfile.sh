#! /bin/bash

# Variables Mpa
COURSE_ID=devsecops12
TOKEN_PARM=$(stat -c "%a" ~/.token)
TOKEN_PATH=~/.token
# Main Script

#Section1
echo Hello $USER
echo $COURSE_ID
echo
/usr/lib/update-notifier/apt-check --human-readable
echo
if [[ -e $TOKEN_PATH ]]; then [[ $TOKEN_PARM ]]
    if [[ "$TOKEN_PARM" != "600"  ]]; then
      echo "Warning: .token file has too wide permissions"
      fi
fi
echo .token file perrmision is: $TOKEN_PARM
echo Done!
