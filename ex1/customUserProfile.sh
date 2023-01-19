# your solution here...
#!/bin/bash
export COURSE_ID=devsecops12
chsh -s $(which zsh)

echo Hello $USER
echo

echo How many packages are outdated?
/usr/lib/update-notifier/apt-check --human-readable
echo

if [ "stat -c "%a" $HOME/token.sh" != '600' ]; then
        echo "Warning: .token file has too open permissions"
        exit 1;
fi
