##!/bin/bash
echo "Hello" $USER
PackagesOutdated= /usr/lib/update-notifier/apt-check --human-readable
echo $PackagesOutdated


if [ -f ~/.token ]; then
  if [ $(stat -c "%a" ~/.token) -ne 600 ]; then
    echo "Warning: .token file has too open permissions"
    else echo "if goes wrong"
  fi
fi

export COURSE_ID=devsecops12
echo $COURSE_ID