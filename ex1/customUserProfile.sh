    #!/bin/bash
    MyId=$(id -gn)
    echo Hello $MyId
    cd /usr/lib/update-notifier
    ./apt-check
    echo '' 'update can be applied immediately.'
    echo To see these additional updates run : apt-list --upgrade
    if test -f /home/.token
    then
       echo  .token file is found
    else
       exit
    fi
    per=$(stat -c %a /home/.token)
    if [ "$per" != "$600" ];
    then
       echo Warning: .token file has too wide permissions
    fi
    export COURSE_ID=devsecops12