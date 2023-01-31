#!/bin/bash
D_SHELL="zsh"

#greetings
echo "Hello $USER"

#print packages updates
CHECK_UPDATES=$(/usr/lib/update-notifier/apt-check --human-readable)
echo "$CHECK_UPDATES"

# .token file permission check
if [ -f "~/.token" ]; then
  permission=$(stat -c "%a" ~/.token)
  if [ "$permission" -ne "600" ]; then
    echo  "Warning: .token file has too open permissions"
  fi
fi

#add "environment" variable COURSE_ID no export
COURSE_ID='devsecope12'

#Set ZSH as default shell
#if [ ! -z $(which $D_SHELL) ]; then
#  chsh -s $D_SHELL
#fi

#exit program
exit 0