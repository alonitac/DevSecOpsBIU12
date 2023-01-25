
#!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable
COURSE_ID="devsecops12"
if [[ !  -f /home/$USER/.token ]]; then
   exit
else
   if [[ "stat -c '%a' /home/$USER/.token" != "600" ]]; then
     echo "Warning:.token file has too open permissions"
   fi
fi
exit

