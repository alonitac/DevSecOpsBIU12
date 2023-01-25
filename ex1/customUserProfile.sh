    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    /usr/lib/update-notifier/apt-check --human-readable
    if  [[test -f "/home/$USER/.token"]];
    then
      per=$(stat -c "%a" "/home/$USER/.token")
    # (($(stat -c "%a" "/home/$USER/.token") != "600"))
   if  [[ "$per" != "600" ]];
    then
        echo 'Warning: .token file has too open permissions'
    fi
    COURSE_ID=devsecops12