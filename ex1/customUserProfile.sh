#!/bin/bash
# Greetings
echo "Hello $USER"

# Print how many packages are outdated
/usr/lib/update-notifier/apt-check --human-readable

# Check the permissions of .token
if [ -f ~/.token ]; then
if [ $perms != "600" ]; then
        echo "Warning: .token file has too wide permissions"
    fi
fi

# Course variable
export COURSE_ID="devsecops12"