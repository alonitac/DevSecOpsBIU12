#!/bin/bash

TOKEN_FILE=/home/$USER/.token
SAFE_PERMISSIONS=600
WARNING_MESSAGE="Warning: .token file has too open permissions"
DEFAULT_SHELL=/bin/zsh

echo Hello "$USER"

/usr/lib/update-notifier/apt-check --human-readable

if [ -f $TOKEN_FILE ]; then
  PERM=$(stat -c %a $TOKEN_FILE)
  if [[ $PERM != $SAFE_PERMISSIONS ]]; then
      echo $WARNING_MESSAGE
  fi
fi
export COURSE_ID=devsecops12
chsh -s $DEFAULT_SHELL
