#!/bin/bash

# 1.1.Greet the user.
echo Greeting ${SUDO_USER^}

# 1.2. Print outdated packages
/usr/lib/update-notifier/apt-check --human-readable

# 1.3. Alert if .token octal representation of the permissions set is different from 600
# executed for .profile, since .token not existing
if   [ $(stat -c "%a" /home/$SUDO_USER/.profile) -ne 600  ]
then

	echo Warning: .profile  file has too open permissions
fi

# 1.4. Add an env var
export COURSE_ID=devsecops12

# 1.5. Define zsh as the default shell for the user
chsh -s /bin/dash $SUDO_USER 
 
