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
if [ -f $FILEPATH ] && [ $(stat -c "%a" $FILEPATH) != "600" ] ; then
        echo  "Warning: $FILENAME file has too open permissions"
else
        exit 0
fi


#add environment virable COURSE_ID devsecope12
COURSE_ID='devsecope12'


#Set ZSH as default shell
if [ ! -z $(which $D_SHELL) ]; then
  chsh -s $D_SHELL
fi

#exit program
exit 0