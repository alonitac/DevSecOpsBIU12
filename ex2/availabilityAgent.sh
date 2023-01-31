#!/bin/bash
TEST_PERIODICITY=5
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true; do
  while read -r TESTED_HOST; do
    TEST_TIMESTAMP=$(date +%s%N)
    RESULT=$(ping -c 1 -W 2 "$TESTED_HOST")
    if [ -n "$RESULT" ]; then
      RESULT=1
    else
      RESULT=0
    fi
    echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done < hosts
  sleep $TEST_PERIODICITY
done
