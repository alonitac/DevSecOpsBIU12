#!/bin/bash

TEST_PERIODICITY=5
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true
do
  while read -r HOST
  do
     time=$(date +%s)
     ping  -c 1 "$HOST"  | awk -v "host=$HOST" -v "time_s=$time" -v "status=0" '/packet loss/ {if ($6 == "0%") status="1" } END { print "Test result for " host  " is " status " at " time_s }'
     curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$HOST value=1 $time"
     sleep 1
  done < hosts
  echo ""
  sleep "$TEST_PERIODICITY"
done
