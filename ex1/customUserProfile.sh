#!/bin/bash

CHECK_UPDATES= /usr/lib/update-notifier/apt-check --human-readable
FILEPATH="/home/$USER/.token"
FILENAME=".token"
D_SHELL="zsh"

#greetings
echo "Hello" $USER

#print packages updates
echo $CHECK_UPDATES

# .token file permission check
# may need to echo permission octal
if [ -f $FILEPATH ]; then
  echo $(stat -c "%a" $FILEPATH)
  if (($(stat -c "%a" $FILEPATH) != 600)); then
    echo  'Warning: .token file has too open permissions'
  fi
fi

#add environment virable COURSE_ID devsecope12
COURSE_ID='devsecope12'

#Set ZSH as default shell
#if [ ! -z $(which $D_SHELL) ]; then
#  chsh -s $D_SHELL
#fi

#exit program
exit 0