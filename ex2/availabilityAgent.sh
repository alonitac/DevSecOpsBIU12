#!/bin/sh

TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"

# read each line in hosts
while true
do
  while read  HOSTS
    do
      TEST_TIMESTAMP=$(date +%s%N)
      ping -c 1 -W 2 "$HOSTS" > /dev/null
      if [ $? != 0 ]
        then
          RESULT="0"
        else
          RESULT="1"
      fi

# DB
      curl -X POST 'http://localhost:8086/query' -u admin:12345678 --data-urlencode "q=CREATE DATABASE hosts_metrics"

# stdout
      echo "Test result for $HOSTS is $RESULT  at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$HOSTS value=$RESULT $TEST_TIMESTAMP"
    done < hosts
    echo

  sleep "$TEST_PERIODICITY"


done