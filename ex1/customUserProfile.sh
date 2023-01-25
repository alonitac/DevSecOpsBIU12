    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    cd /usr/lib/update-notifier
    ./apt-check --human-readable
    echo '' 'update can be applied immediately.'
   # echo To see these additional updates run : apt-list --upgrade
    if ! test -f /home/.token
    then
         exit
     fi
    if (($(stat -c %a "/home/.token") != 600))
    then
      echo Warning: .token file has too wide permissions
    else
      exit
    fi
    export COURSE_ID=devsecops12