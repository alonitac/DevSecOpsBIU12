#!/bin/bash

# Print user  welcome
 echo $USER Hello

#print number of out of date softwares
/usr/lib/update-notifier/apt-check --human-readable | grep updates
#create token file
sudo touch /home/$USER.token

TOKEN_PATH=/home/$USER.token

ab=${stat -c "%a" TOEKN_PATH} 

if [ab -g 600]
then
        echo "good news all fine"
else
        echo "warning security issues"
