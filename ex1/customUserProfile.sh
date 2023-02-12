# your solution here...
#! /bin/bash
echo "Hello" $USER
/usr/lib/update-notifier/apt-check --human-readable

if [[ -f ~/.token ]] ; then
if [[ "$(stat -c %a ~/.token)" -ne 600 ]]; then
   echo "Warning: .token file has too open permissions"
 fi
 COURSE_ID="devsecops12"
fi


