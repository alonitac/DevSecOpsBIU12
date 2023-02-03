#!/bin/bash

TEST_PERIODICITY=5
#To Run :
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true
do
# Loop through each line in the file
while read -r TESTED_HOST; do
#Check and forward the latency  from Ping command to "RESULT" Variable:
RESULT=$(ping  -c 1 -W 2 "$TESTED_HOST"  | grep -oP '(?<=time=)\d+(\.\d+)?')

# Check if the ping was received and print
  if [[ $? -ne 0 ]]; then
 #Ping failure:
    RESULT=0
  fi
  TEST_TIMESTAMP=$(date +%s%N)
  # Report the epoch timestamp in nanoseconds and the test result
  echo "Ping Result For "Host:" $TESTED_HOST "Latency:"$RESULT "Timestamp:"$TEST_TIMESTAMP"

curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"

done < hosts
  echo "<=============================================================>"
  sleep $TEST_PERIODICITY
done
