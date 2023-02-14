# Print user  welcome
echo $USER Hello

#print number of out of date softwares
/usr/lib/update-notifier/apt-check --human-readable | grep updates

sudo touch ~/$USER.token

stat -c "%a" ~/$USER.token = $AB

if [$AB =< 600]

then
echo "Warning the $USER"

fi [echo "All Good"]
#!bin/bash

#greeting the user
echo "Hello" $USER

#check & print how many packages are outdated
UPDATE= /usr/lib/update-notifier/apt-check --human-readable
echo $UPDATE

#create file .token and check permissions ststus

#touch $HOME/.token
CURPERM=$(stat -c "%a" .token)

APERM='600'

if [ -a ~/.token ]; then
  if [ $CURPERM != $APERM ];
    then
        echo "Warning: .token file has too open permissions"
  fi
fi
#setting up an environment variable
COURSE_ID=devsecops12

#change the default shell to zsh
chsh -s /usr/bin/zsh
