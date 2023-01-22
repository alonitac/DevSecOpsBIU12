echo "Hello $USER"
# Print outdated
/usr/lib/update-notifier/apt-check --human-readable
# Check if token file exist and the permissions of .token
TOKEN_PATH=/home/$USER/.token
if [[ -f "$TOKEN_PATH" ]]; then PERM=$(stat -c "%a" "$TOKEN_PATH")
   if [[ $PERM != "600" ]]; then echo "Warning: .token file has too open permissions"

fi

fi
# Course variable
COURSE_ID="devsecops12"
