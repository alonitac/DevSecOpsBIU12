#!bin/bash
#Greeing the user:
echo "Hello $USER"

#Print how many packages are outdated:
/usr/lib/update-notifier/apt-check --human-readable 

#now we check if there is .token file at home directory if yes will check permissions 
if [ -f ~/token ] ;
then
if [ "(stat -c %a ~/.token)" != "600"] ;
then 
echo "Warning: .token file has too wide permissions"
fi

#environment variable called COURSE_ID with a value equals to devsecops12:
COURSE_ID="devsecops12"
fi

