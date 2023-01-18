#!/bin/bash
echo "Hello $USER"

echo "Update available: $(/usr/lib/update-notifier/apt-check --human-readable)"
echo "To see these additional updates run: apt list --upgrade"

token_p=/home/$USER/.token
if [[ -e "$token_p" ]]; then
    permissions=$(stat -c "%a" "$token_p")
    if [[ $permissions != "600" ]]; then
        echo "Warning: .token file has too wide permissions"
    fi
COURSE_ID=devsecops12
fi

