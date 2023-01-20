#! /bin/bash

# Variables Mpa
COURSE_ID=devsecops12
TOKEN_PARM=$(stat -c "%a" "$TOKEN_PATH")
TOKEN_PATH=~/.token
# Main Script

# Greetings
echo "Hello $USER"
# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable
# Check the permissions of .token
if [[ -f "$TOKEN_PATH" ]]; then "$TOKEN_PARM"
    if [[ $TOKEN_PARM != "600"  ]]; then
      echo "Warning: .token file has too wide permissions"
      fi
fi
echo .token file perrmision is: "$TOKEN_PARM"
echo Done!
# Course variable
echo "$COURSE_ID"
echo Done!