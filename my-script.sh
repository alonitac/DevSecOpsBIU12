#!/bin/bash

if ! command -v jq &> /dev/null
then
    echo "jq is not installed. Please download it from https://stedolan.github.io/jq/download/"
    exit 1
fi

ip_address=$1

if [ $# -ne 1 ] || [[ $ip_address = '127.0.0.1' ]]
then
    echo "Please provide exactly one argument representing the IP address to check."
    echo "IP address cannot be '127.0.0.1'."
    exit 1
fi

RESPONSE=$(curl -s "http://ip-api.com/json/$ip_address")

echo $RESPONSE | jq -r '.country'
echo $RESPONSE | jq -r '.city'
echo $RESPONSE | jq -r '.regionName'





