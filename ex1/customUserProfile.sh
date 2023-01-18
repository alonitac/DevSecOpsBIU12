#! /bin/bash

echo "Hello $USER"

echo ""


/usr/lib/update-notifier/apt-check --human-readable


echo  "" 


if [ -a ~/.token ] ; then  
 if [ "$(stat -c "%a" ~/.token)" ] != 600 ; then
   echo "Warning: .token file has too wide permissions" 
 fi
else
 echo "file .token not exist"  
fi
