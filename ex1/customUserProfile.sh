#!/bin/bash
#inside .bash_profile no shabang needed
#but for the sake of compatibitlity with ordinary shell script file placed
#at start
echo "Hello "$USER
#? Next one to run and check
/usr/lib/update-notifier/apt-check --human-readable
if [  -e "/home/$USER/.token" ];then
    FILE_PERM=$(stat -c "%a" "/home/$USER/.token")

    if [[ "$FILE_PERM" != "600" ]]; then
      echo "Warning: .token file has too open permissions"
    fi
    COURSE_ID="devsecops12"
fi


