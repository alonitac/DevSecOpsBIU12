#!/bin/bash
#Print all user message
echo "Hello" $USER
#Print packages outdated
/usr/lib/update-notifier/apt-check --human-readable
#File permissions
TOKEN_PATH=/home/$USER/.token
if [[ -f "$TOKEN_PATH" ]]; then PERM=$(stat -c "%a" "$TOKEN_PATH")
  if [[ $PERM != "600" ]]; then echo "Warning: .token file has too open permissions"
  fi
#Add an environment
COURSE_ID="devsecops12"
fi
#Define zsh as the default shell for the user

