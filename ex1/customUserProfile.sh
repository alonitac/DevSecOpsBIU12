#!/bin/bash
# Greetings
echo "Hello $USER"
# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable
# Check the permissions of .token
TOKEN_PATH=/home/$USER/.token
if [[ -f "$TOKEN_PATH" ]]; then PERM=$(stat -c "%a" "$TOKEN_PATH")
  if [[ $PERM != "600" ]]; then echo "Warning: .token file has too open permissions"
  fi
# Course variable
COURSE_ID="devsecops12"
fi