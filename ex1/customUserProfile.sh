#!/bin/bash
	# Greet the user
	echo "Hello $USER"
	# Print how many packages are outdated
	/usr/lib/update-notifier/apt-check --human-readable
	#  Checking the file permission
	TOKEN_PATH=/home/$USER/.token
	if [[ -f "$TOKEN_PATH" ]]; then USERPERM=$(stat -c "%a" "$TOKEN_PATH")
	  if [[ $USERPERM != "600" ]]; then echo "Warning: .token file has too open permissions"
	  fi
	# Course ID
	COURSE_ID="devsecops12"
	fi
	TERMINAL="zsh"
	# End EX1
