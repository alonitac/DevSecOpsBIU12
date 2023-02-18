#!bin/bash
echo "Hello $USER"

echo "Update available: $(/usr/lib/update-notifier/apt-check --human-readable)"

if [[ -e "/home/$USER/.token" ]]; then
    permissions=$(stat -c "%a" "/home/$USER/.token")
    if [[ "$permissions" != "600" ]]; then
        echo "Warning: .token file has too open permissions"
    fi
COURSE_ID="devsecops12"
fi