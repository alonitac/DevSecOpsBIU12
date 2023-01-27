#!/bin/bash

#Check if jq is install
if ! [ -x "$(command -v jq)" ]; then
        echo "Error: jq is not installed, Please download it from https://stedolan.github.io/jq/download/"
        exit 1
else
        echo "Check Success - jq is installed correctly"
fi

echo ""

#Check that exactly one argument was passed to the script
if [ $# -ne 1 ]; then
        echo "Error: Please provide a single IP address as an argument"
else
        echo "There is exactly one argument"
fi

echo ""

#Check that the IP argument is not equal to '127.0.0.1'
if [ "$1" == "127.0.0.1" ]; then
        echo "Error: IP address cannot be '127.0.0.1'"
else
        echo "This IP address is Good"
fi

echo ""

#Perform HTTP GET request to retrieve geo-location details
response=$(curl -s "http://ip-api.com/json/$1")

#check that the request was successful
status=$(echo $response | jq -r '.status')
if [ "$status" != "success" ]; then
        echo "Error: Failed to retrieve geo-location details for given IP address"
        exit 1
else
        echo "Success to retrieve geo-location details for given IP address"
fi

echo ""

#Excract and print country, city and region name from response
country=$(echo $response | jq -r '.country')
city=$(echo $response | jq -r '.city')
region=$(echo $response | jq -r '.regionName')

echo "Country: '$country'"
echo "City: '$city'"
echo "Region: '$region'"