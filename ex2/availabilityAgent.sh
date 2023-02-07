#!/bin/bash

TEST_PERIODICITY=5

while true
do
  while read -r HOST
  do
    ping -c 1 -W 2 $HOST > /dev/null
    EXIT_STATUS=$?
    echo "Test result for $HOST is $EXIT_STATUS at $(date +%s)"
    TEST_TIMESTAMP=$(date +%s)
    RESULT=$(ping -c 1 -W 2 $HOST)
    export DB_USERNAME=admin
    export DB_PASSWORD=12345678
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u "$DB_USERNAME:$DB_PASSWORD" --data-binary "availability_test,host=$HOST value=$EXIT_STATUS $TEST_TIMESTAMP"
  done < hosts
  sleep "$TEST_PERIODICITY"
done


