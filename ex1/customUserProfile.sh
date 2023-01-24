
#!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable

if [[ -f /home/$USER/.token ]]; then
   if [[ "stat -c '%a' /home/$USER/.token" != "600" ]]; then
     echo "Warning: .token file has too open permissions"
   fi
   else
     exit
fi
COURSE_ID="devsecops12"
exit
