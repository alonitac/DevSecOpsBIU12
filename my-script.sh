#!/bin/bash

# Check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
  echo "Error: jq is not installed. Please download it from https://stedolan.github.io/jq/download/"
  exit 1
fi

# Check if exactly one argument was sent
if [ "$#" -ne 1 ]; then
  echo "Error: Please provide exactly one argument (IP address)"
  exit 1
fi

# Check if the IP argument is not equal to '127.0.0.1'
if [ "$1" == "127.0.0.1" ]; then
  echo "Error: Please provide a valid IP address other than '127.0.0.1'"
  exit 1
fi

# Perform HTTP GET request and store response in variable
RESPONSE=$(curl -s "http://ip-api.com/json/$1")

# Check if the request was successful by checking the status key
STATUS=$(echo "$RESPONSE" | jq -r '.status')
if [ "$STATUS" != "success" ]; then
  echo "Error: Request was not successful. Please check the provided IP address and try again."
  exit 1
fi

# Print geo-location details
echo "Country: $(echo "$RESPONSE" | jq -r '.country')"
echo "City: $(echo "$RESPONSE" | jq -r '.city')"
echo "Region: $(echo "$RESPONSE" | jq -r '.regionName')"
