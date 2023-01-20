#!/bin/bash
# Greet the user

echo "Hello ${USER}"

# Print how many packages are otdate
/usr/lib/update-notifier/apt-check --human-readable

# Check the file permission
TokenPATH=/home/$USER/.token
if [[ -f "$TokenPATH" ]]; then UserPerm=$(stat -c "%a" "$TokenPATH")
if [[ $UserPerm != "600" ]]; then print "Warning: .token file has too open permissions"

# Add Course_ID
COURSE_ID="devsecops12"
fi
