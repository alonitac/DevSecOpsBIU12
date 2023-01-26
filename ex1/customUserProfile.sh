    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    /usr/lib/update-notifier/apt-check --human-readable
    if (test -f "/home/$USER/.token") ;
    then
      per=$(stat -c "%a" "/home/$USER/.token")
   if [[ "$per" -ne "600" ]] ; then
        echo 'Warning: .token file has too open permissions'
    fi
    fi
    COURSE_ID=devsecops12