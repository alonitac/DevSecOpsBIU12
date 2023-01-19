!/bin/bash

echo "Hello $USER"
/usr/lib/update-notifier/apt-check --human-readable
if [ "stat -c '%a' .token" != "600" ]; then
    echo "Warning: .token file has too open permissions"
fi
