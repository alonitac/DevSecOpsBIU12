#!/bin/bash

# Greetings
echo "Hello $USER"

# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable


# Check the permissions of .token
if [ -f ~/.token ]; then
    perms=$(stat -c "%a" ~/.token)
    if [ $perms != "600" ]; then
        echo "Warning: .token file has too wide permissions"
    fi

# Course variable
COURSE_ID="devsecops12"
fi