#!/bin/bash

TEST_PERIODICITY=5

while true
do
  #Iterates through each line in the file "hosts"
  for HOST_OR_IP in $(cat ./hosts); do
    #Sets the current timestamp in seconds with nanoseconds
    PING_TIMESTAMP=$(date +%s%N)
    #Pings the host or IP and redirects output to null
    ping -c 1 -W 1 $HOST_OR_IP &> /dev/null
    #Return code of the previous command
    if [[ $? -eq 0 ]]
    then
      RETURN_CODE=1
    else
      RETURN_CODE=0
    fi
    echo "The result for $HOST_OR_IP is $RETURN_CODE at $PING_TIMESTAMP"
    #Sends a POST request to InfluxDB with the ping result data
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' --data-binary "availability_test,host=$HOST_OR_IP value=$RETURN_CODE $PING_TIMESTAMP"
  done
  #Pauses the script for the number of seconds specified in TEST_PERIODICITY
  sleep $TEST_PERIODICITY
done



