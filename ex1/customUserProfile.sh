#bin/bash
      #
      ##greeting the user
      #echo Hello $user
      #
      ##print outdated packages
      #(/usr/lib/update-notifier/apt-check --human-readble)
      #
      ##check .token file permissions
      #if [ -f ~/.token ]; then
      #  permissions=$( stat -c "%a" ~/.token)
      #  if [ "$permissions != "600" ]; then
      #     echo "warning .token file has too open permissions"
      #     fi
      #     fi
      #
      ##set course env
      #course_ID=$devsecops12 solution here...