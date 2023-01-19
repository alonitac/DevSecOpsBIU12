#!/bin/bash

TOKEN_FILE=~/.token
SAFE_PERMISSIONS=600
WARNING_MESSAGE="Warning: .token file has too open Permissions"
TOKEN_FILE_CREATED_MESSAGE=".token file created successfully"
DEFAULT_SHELL=/bin/zsh

echo Hello "$USER"

/usr/lib/update-notifier/apt-check --human-readable

if [ -f $TOKEN_FILE ]; then
if [ "$(stat -c %a $TOKEN_FILE)" != $SAFE_PERMISSIONS ]; then
    echo $WARNING_MESSAGE
fi
else
  touch $TOKEN_FILE
  chmod $SAFE_PERMISSIONS $TOKEN_FILE
  echo $TOKEN_FILE_CREATED_MESSAGE
fi
export COURSE_ID=devsecops12
chsh -s $DEFAULT_SHELL
zsh