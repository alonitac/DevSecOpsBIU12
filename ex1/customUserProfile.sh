#!/bin/bash

echo "Hello $USER"


/usr/lib/update-notifier/apt-check --human-readable



if [ -f ~/.token ] ; then
 if [ "$(stat -c %a ~/.token)" != "600" ]   ; then
   echo "Warning: .token file has too wide permissions" 
 fi
 COURSE_ID="devsecops12"
fi
