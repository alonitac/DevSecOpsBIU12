#!/bin/bash
TEST_PERIODICITY=5
export DB_USERNAME="admin"
export DB_PASSWORD="12345678"

while true

do
  while read -r TESTED_HOST
  do
    RESULT=$( ping -c 1 -W 2 $TESTED_HOST | grep -c "icmp_seq=1" )
    TEST_TIMESTAMP=$(date +%s)
      if [ $RESULT -eq 1 ]
         then echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
         else echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
      fi

  done < hosts

  sleep "$TEST_PERIODICITY"
done
