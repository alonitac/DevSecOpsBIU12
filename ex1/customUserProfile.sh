#!/bin/bash
# greet the user

echo "Hello ${USER}"

UPDATE= /usr/lib/update-notifier/apt-check --human-readable

 # display the count of updates

echo  $UPDATE


# create .token file

#touch $HOME/.token
# check file permissions
TOKEN_FILE=/home/$USER/.token

NUM='600'

# compare permissions
if [ -f $TOKEN_FILE ] ; then
  TOKEN=$(stat -c "%a" $TOKEN_FILE)
  if [ $TOKEN != $NUM ] ; then
    echo " Warning: .token file has too open permissions "
  fi
fi

COURSE_ID=devsecops12