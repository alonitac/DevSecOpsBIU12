##!/bin/bash

 COURSE_ID="devsecops12"
export COURSE_ID

echo "hello $USER"

/usr/lib/update-notifier/apt-check --human-readable

if [ -f ~/.token ]; then
  permission=$(stat -c "%a" ~/.token)
  if [ "$permission" != "600" ]; then
    echo "Warning: .token file has too open permissions"
    fi
    fi

