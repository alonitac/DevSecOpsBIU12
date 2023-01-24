# Greet the user
echo "Hello $USER"

# Check for outdated packages
outdated=$(/usr/lib/update-notifier/apt-check --human-readable)
echo "$outdated"

# Check file permissions of .token file
if [ -f ~/.token ]; then
  permissions=$(stat -c "%a" ~/.token)
  if [ "$permissions" != "600" ]; then
    echo "Warning: .token file has too open permissions"
  fi
fi

# Set COURSE_ID environment variable
# export COURSE_ID=devsecops15