#!/bin/bash
#Greetings to all user
echo "Hello" $USER

/usr/lib/update-notifier/apt-check --human-readable

TOKEN_PATH=/home/$USER/.token
if [[ -f "$TOKEN_PATH" ]]; then
  PERM=$(stat -c "%a" "$TOKEN_PATH")
  if [[ $PERM != "600" ]]; then
    echo "Warning: .token file has too open permissions"
  fi
COURSE_ID="devsecops12"
fi