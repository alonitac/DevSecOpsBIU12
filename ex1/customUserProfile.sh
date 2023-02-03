echo "Hello" $USER
PackagesOutdated= /usr/lib/update-notifier/apt-check --human-readable
echo $PackagesOutdated
echo "To see these additional updates run: apt list --upgradable"
if [ -f ~/.token ]; then
if [ $( stat -c '%a' ~/.token ) -ne 600 ]; then
echo "Warning: .token file has too wide permissions"
fi
fi

export COURSE_ID=devsecops12
echo $COURSE_ID
