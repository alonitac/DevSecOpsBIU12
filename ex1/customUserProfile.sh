#!/bin/bash
echo "Hello $USER"

echo "Update available: $(/usr/lib/update-notifier/apt-check --human-readable)"

echo "To see these additional updates run: apt list --upgrade"

TOKEN=/home/$USER/.token
if [[ -e "$TOKEN" ]]; then
    permissions=$(stat -c "%a" "$TOKEN")
    if [[ $permissions != "600" ]]; then
        echo "Warning: .token file has too wide permissions"
    fi
COURSE_ID="devsecops12"
fi