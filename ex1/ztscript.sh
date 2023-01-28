#!/bin/bash

JQPACK=jq
DPKG=$(which $JQPACK)
LOCALHOST=127.0.0.1
IPADDRESS=$1

#checks if jq cli is installed
if [ -z $DPKG ]
then
    echo "jq not installed"
    echo "Please download from this link https://stedolan.github.io/jq/download/"
    exit 1
fi

#Need to be just exactly one argument
if [ "$#" -ne 1 ]
 then
  echo "Just 1 argument must be provided"
  exit 2
fi

#Checking that given IP argument is not equal to '127.0.0.1'
if [ "$1" == "$LOCALHOST" ]
then
  echo "Must be another IP from 127.0.0.1"
  exit 3
fi

#HTTP GET request, store the results in a variable
RESULT=$(curl -S http://ip-api.com/json/$IPADDRESS)

#Check if that the request has been succeeded
#If the request succeed, print the following information to the user -> country, city, regionName
if echo $RESULT | jq -r '.status' | grep success
then
  echo $RESULT | jq -r '.country'
  echo $RESULT | jq -r '.city'
  echo $RESULT | jq -r '.regionName'
  exit 4
fi





