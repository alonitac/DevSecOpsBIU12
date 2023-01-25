
#!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable

if [[ !  -f /home/$USER/.token ]]; then
   COURSE_ID="devsecops12"
else
   if [[ "stat -c '%a' /home/$USER/.token" != "600" ]]; then
     echo "Warning:.token file has too open permissions"
     COURSE_ID="devsecops12"
   fi
fi
exit

