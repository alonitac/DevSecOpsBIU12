    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    cd /usr/lib/update-notifier
    ./apt-check --human-readable
    echo '' 'update can be applied immediately.'
    #if ! test -f /home/$USER/.token
    #then
     #   exit
    if  test -f /home/$USER/.token
     then per=$(stat -c "%a" "/home/$USER/.token")
       #(($(stat -c "%a" "/home/$USER/.token") != "600"))
    if  [ $per != "600" ];
    then
        echo 'Warning: .token file has too open permissions'
    else
        exit
    fi
    COURSE_ID=devsecops12