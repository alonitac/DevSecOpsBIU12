#!/bin/bash

# CONST
TOKEN="/home/$USER/.token"
TERMINAL="zsh"




# WELCOME NOTIFICATION
echo "Hello $USER"
echo

# DISPLAY AVALIABLE UPDATES
/usr/lib/update-notifier/apt-check --human-readable
echo

# CHECK IF THE TOKEN IS EXIST
if [[ -e $TOKEN ]]; then
    # File exist, continue with checks
    if [ $(stat -c "%a" "$TOKEN") -ne 600 ]; then
        # File is existed and protected
        echo "Warning: $(echo $TOKEN | awk -F/ '{print $NF}') file has too open permissions"
    fi
fi
echo


# DEFINE ENVIRONMENT VARIABLES
export COURSE_ID="devsecops12"


# DEFINE ZSH TERMINAL
if [ -x "$(which zsh)" ]; then
 $TERMINAL
fi

# END OF SCRIPT
