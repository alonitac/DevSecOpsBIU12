#!/bin/bash

TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"

while true; do  #while loop forever
  while read line; do
  results=$(ping -c 1 -W 2 "$line") #This variable was print the ping for each line into the hosts file
  latency=$(echo "$results" | grep -oP '(?<=time=)\d+(\.\d+)?')
  test_results=$?
  time=$(date +%s%N) #The date CMD cat the timestamp in nanoseconds
  if [ $test_results -eq 0 ]; then #Present the test results
    test_results=1
  else
    test_results=0
  fi
  if [ -n "$latency" ]; #latency verifications
  then
   latency="$latency"
  else
    latency=0
  fi
#echo the test results to stdout
  echo "Test result for $line is $test_results at $time"
  #echo latency = "$latency"
  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$line value=$latency"

done < hosts  #hosts present the file that i want to read
echo  "Print to DB :)"
echo TimeOut For 5s
sleep $TEST_PERIODICITY

done
