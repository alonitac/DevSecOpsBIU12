#!/bin/bash
export DB_USERNAME=admin
export DB_PASSWORD=12345678
TEST_PERIODICITY=5

while true; do
  while read -r line; do
    ping -c 1 -W 2 $line > /dev/null
    test_result=$?
    time=$(($(date +%s%N)/1000000))
    echo "Test result for $line is $test_result at $time"


curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$line value=$test_result $time"
  done < hosts

sleep "$TEST_PERIODICITY"
done
