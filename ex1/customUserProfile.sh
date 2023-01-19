!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable
touch $HOME/.token
if  [[ ! -e $HOME/.token ]]; then
     touch $HOME/.token
fi
if [ "stat -c '%a' .token" != "600" ]; then
    echo "Warning: file has too open permissions"
fi
