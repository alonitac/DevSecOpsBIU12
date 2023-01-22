#!bin/bash
#Greeing the user:
echo "Hello $USER"
echo ""



#Print how many packages are outdated:
/usr/lib/update-notifier/apt-check --human-readable 
echo ""

#now we check if there is .token file at home directory if yes will check permissions
if [ -e ~/.token  ]
then if [ "$(stat -c "%a" ~/.token)" != "600" ]
 then echo Warning: .token file has too open permissions
fi
fi

#environment variable called COURSE_ID with a value equals to devsecops12:
export COURSE_ID="devsecops12"
echo ""

exit 1




