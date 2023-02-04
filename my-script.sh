#!/bin/bash
which jq &> /dev/null
if [ $? -eq 1 ]
 then echo "the package is not installed you can download it from the URL: https://stedolan.github.io/jq/download/"
fi
if [ $# -ne 1 ]
 then echo "Please enter one IP address"
 exit 1
fi
if [ $1 == "172.0.0.1" ]
 then echo "Please enter other valid ip address then 172.0.0.1"
 exit 1
fi
RESPONSE=$( curl http://ip-api.com/json/"$1" 2>/dev/null )
Status=$( echo "$RESPONSE" | jq -r '.status')
if [ "$Status" = "success" ]
then echo
Country=$( echo "$RESPONSE" | jq -r '.country')
City=$( echo "$RESPONSE" | jq -r '.city')
Region_Name=$( echo "$RESPONSE" | jq -r '.regionName')
echo Region Name: $Region_Name
echo Country: $Country
echo City: $City

fi