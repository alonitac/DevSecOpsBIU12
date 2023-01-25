#!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    /usr/lib/update-notifier/apt-check --human-readable
    if  test -f /home/$USER/.token ; then
      echo $(stat -c "%a" "/home/$USER/.token")
     if (($(stat -c "%a" "/home/$USER/.token") > 600)) ; then
           echo 'Warning: .token file has too open permissions'
     fi
    fi
    export COURSE_ID=devsecops12
