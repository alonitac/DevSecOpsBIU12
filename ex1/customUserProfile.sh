#!/bin/bash
#Greetings to all user
echo "Hello" $USER

#Print how many packages are outdated
PackagesOutdated= /usr/lib/update-notifier/apt-check --human-readable
echo $PackagesOutdated

#check the file permissions,If the octal representation of the permissions set is different from 600
TokenPath=/home/$USER/.token
if [[ -f "$TokenPath" ]];
 then
  UserPerm=$(stat -c "%a" "$TokenPath")
  if [[ $UserPerm != "600" ]]; then
    #print a warning message to the user
    echo "Warning: .token file has too open permissions"
  fi
  #environment variable called COURSE_ID with a value equals to devsecops12
COURSE_ID="devsecops12"

#change the default shell to zsh for the newuser
chsh -s /usr/bin/zsh

fi

