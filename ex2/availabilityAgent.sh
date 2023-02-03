#!/bin/bash

TEST_PERIODICITY=5
#To Run :
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true
do
# Loop through each line in the file
while read -r TESTED_HOST
 do
#Check and forward the latency  from Ping command to "RESULT" Variable:
    RESULT=$(ping  -c 1 -W 2 "$TESTED_HOST"  | grep -oP '(?<=time=)\d+(\.\d+)?')
      TEST_TIMESTAMP=$(date +%s%N)

# Check if the ping was received and return the value :
        if [[ -n "$RESULT" ]]
        then
          ReturnValue="$RESULT"
          else
            ReturnValue=0
            fi

  echo "Test Result For $TESTED_HOST is $ReturnValue at $TEST_TIMESTAMP"
  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$ReturnValue $TEST_TIMESTAMP"

 done < hosts
  echo ""
  sleep $TEST_PERIODICITY
done
