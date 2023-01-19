
#!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable
if  [[ -e $HOME/.token ]]; then
    if [ "stat -c '%a' .token" != "600" ]; then
    echo "Warning: file has too open permissions"
    fi

fi
