
#!/bin/bash
echo "Hello" $USER
/usr/lib/update-notifier/apt-check --human-readable
FILE_PATH=/home/$USER/.token
if [[ -e "$FILE_PATH" ]]; then
  FILE_PERM=$(stat -c "%a" "$FILE_PATH")
  if [[ $FILE_PERM != "600" ]]; then
    echo "Warning: .token file has too open permissions"
  fi
COURSE_ID="devsecops12"
fi

