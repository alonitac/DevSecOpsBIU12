#! /bin/bash
echo Hello $USER
echo $(/usr/lib/update-notifier/apt-check --human-readable)

if [ -f /home/$USER/.token ]; then
  stat -c "%a" /home/$USER/.token ; then if [ $? != 600 ]; then echo "Warning: .token file has too open permissions
"
    
fi