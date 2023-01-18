echo "Hello $USER"

echo "Update available: $(/usr/lib/update-notifier/apt-check --human-readable)"
echo "To see these additional updates run: apt list --upgrade"


if [ -e ~/.token ]; then
    permissions=$(stat -c "%a" ~/.token)
    echo "Permissions for .token file: $permissions"
    if [ $permissions != "600" ]; then
        echo "Warning: .token file has too wide permissions"
    fi
fi


export COURSE_ID=devsecops12