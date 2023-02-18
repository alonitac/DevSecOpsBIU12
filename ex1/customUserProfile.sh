# your solution here...
#!bin/bash

me="$(whoami)"
echo "hello $me"
echo -e '\n'
echo "$(/usr/lib/update-notifier/apt-check --human-readable)"
echo -e '\n'

t=$HOME/.token

# check if the .token file exists in the home directory
if [ -f "$t" ]; then
  # get the octal representation of the file permission
  perm=$(stat -c "%a" "$t")

  # check if the permission is different from 600
  if [ "${perm}" != "600" ]; then
    echo "Warning: .token file has too open permissions"
  fi
else
  echo "Error: .token file not found in home directory"
fi


export COURSE_ID=devsecops12