#!/bin/bash
# greet the user

echo "Hello ${USER}"

UPDATE= /usr/lib/update-notifier/apt-check --human-readable

 # display the count of updates

echo  $UPDATE


# create .token file

touch $HOME/.token
# check file permissions

TOKEN=$(stat -c "%a" $HOME/.token)
NUM='600'

# compare permissions
if [ -f "$HOME"/.token ] ; then
  if [ "$TOKEN" != "$NUM" ] ; then
    echo " Warning: .token file has too wide permissions "
  fi
fi

COURSE_ID=devsecops12