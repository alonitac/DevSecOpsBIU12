#!/bin/bash
TEST_OF_AMOUNT=5
i=0
total_of_count=6
while (( i < $total_of_count ))
do
  for host in $(cat  hosts)
  do
    host=$(echo $host|awk '$1=$1')
    if [[ ! $host == "" ]]
    then

      bash -c "echo -e 'at:$(date +%s)'&&ping -c 1 -W 2 $host">~/requestResult.txt

      requestSucceeded=0
      dateNTimeOfRequest=0

      if [[ $? == "0" ]]
      then
        requestSucceededStr=$(cat ~/requestResult.txt|grep -E "\,([ ]){1,1}([0-9]){1,}([ ]){1,1}received"|awk  '/([0-9])+/{print($4)}'|awk '$1=$1')
        requestSucceeded=$(
        if [[ $requestSucceededStr == "1" ]]
        then
          echo $requestSucceededStr

        else
          echo "0"
        fi)

        dateNTimeOfRequest=$(cat ~/requestResult.txt|grep  -E "at:([0-9])+"|awk  -F ":" '{print $2}'|awk '$1=$1')

        export RESULT="$requestSucceeded"
        echo "Test result for ${host} is ${requestSucceeded} at ${dateNTimeOfRequest}"
        export TESTED_HOST="${host}"
        export TEST_TIMESTAMP="${dateNTimeOfRequest}"
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
      fi

      

    else
      :
    fi
  done
  (( i= i + 1 ))

  sleep "$TEST_PERIODICITY"
done
