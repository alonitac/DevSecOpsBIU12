#!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable
if [ "stat -c '%a' $HOME/.token" != "600" ]; then
    echo "Warning: .token file has too open permissions"
fi
export COURSE_ID="devsecops12"
