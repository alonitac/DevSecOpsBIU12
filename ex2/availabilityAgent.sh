#!/bin/bash

TEST_PERIODICITY=5
DB_USERNAME=admin
DB_PASSWORD=12345678

while true
do
  while read -r HOST
    do
     TIME=$(date +%s)
     STATUS=$(ping -c 1 -w 2 "$HOST" | grep -c "1 received")
     echo "Test result for $HOST is $STATUS at $TIME"
     curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$HOST value=$STATUS $TIME"
    done < hosts
  sleep "$TEST_PERIODICITY"
done


