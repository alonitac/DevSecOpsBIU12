    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    cd /usr/lib/update-notifier
    ./apt-check --human-readable
    echo '' 'update can be applied immediately.'
    if ! test -f /home/.token
    then
        exit
    elif (($(stat -c %a "/home/.token") != 600))
    then
        echo 'Warning: .token file has too open permissions'
    else
        exit
    fi
   export COURSE_ID=devsecops12