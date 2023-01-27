#!/bin/bash

IP=$1

echo " Hi $USER ! Checking if JQ command is installed PLEASE WAIT.."
sleep 2
if [  jq  &> /dev/null ]
then
  echo " JQ command exists !"
  sleep 2
else
  echo " please download it from https://stedolan.github.io/jq/download/ or use "sudo apt-get install jq""
fi

# check if there is more then 1 argument

if [ $# -gt 1 ]
then
  echo "more then 1 argument entered plese enter just 1!"
  exit 1
elif [[ $IP == 127.0.0.1 ]]
  then 
    echo "127.0.0.1 is not allowed please enter another ip address"
    exit 2
fi

    CURL=$(curl http://ip-api.com/json/$IP)
    echo "COUNTRY:"
    echo $CURL | jq -r '.country'
    echo "region:"
    echo $CURL | jq -r '.region'
    echo "regionName:"
    echo $CURL | jq -r '.regionName'



