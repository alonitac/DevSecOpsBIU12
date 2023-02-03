#!/bin/bash

TEST_PERIODICITY=5
export DB_USERNAME=admin
export DB_PASSWORD=12345678

while true
do
  # Your code here....
while read line
do
  RESULT=$(ping -c 1 -W 2 "$line"| grep -c "icmp_seq=1")
  NANOTIME=$(date +%s%N)
        if [[ $RESULT = 0 ]]
        then
          RESULT=0
          else
            RESULT=1
            fi
        echo Test result for $line is $RESULT at $PINGTIME
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$line value=$RESULT $NANOTIME"
done < hosts
echo
sleep $TEST_PERIODICITY
done
