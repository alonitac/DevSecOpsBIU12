#!/bin/bash
DB_USERNAME="admin"
DB_PASSWORD="12345678"
TEST_PERIODICITY=5
TEST_PERIODICITY=5
# While loop read the each line in hosts

while true
do
while true; do
  while read host; do
# Run ping command
    if ping -c 1 -W 2 $host > /dev/null; then
      result=1
    else
      result=0
    fi

    # Print the test result to stdout
    echo "Test result for $host is $result at $(date +%s%N)"

  done < hosts

  # Wait for the next check test ping
  sleep $TEST_PERIODICITY

done

sleep "$TEST_PERIODICITY"
done

#Write test results to a database

curl -X POST 'http://localhost:8086/query' -u admin:12345678 --data-urlencode "q=CREATE DATABASE hosts_metrics"

curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"

# end