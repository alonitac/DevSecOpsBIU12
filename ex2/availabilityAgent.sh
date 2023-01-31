#!/bin/bash

TEST_PERIODICITY=5
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true
do
  while read -r HOST
  do
     time=$(date +%s)
     status_latency=$(ping  -c 1 -W 2 "$HOST"  | grep -oP '(?<=time=)\d+(\.\d+)?')
     if [[ "$status_latency" = "" ]] ; then
       status_latency=0
     fi
     echo "Test result for $HOST is $status_latency at $time"
     curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$HOST value=$status_latency $time "
     #sleep 1
  done < hosts
  echo ""
  sleep "$TEST_PERIODICITY"
done
