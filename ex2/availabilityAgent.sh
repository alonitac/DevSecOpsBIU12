#!/bin/bash
TEST_PERIODICITY=5
i=0
total_count=6
while (( i < $total_count ))
##true
do
  #export DB_USERNAME="admin"
  #export DB_PASSWORD="12345678"
  # Your code here....
  for host in $(cat  hosts)
  do
    host=$(echo $host|awk '$1=$1')
    #echo "Host:"$host
    if [[ ! $host == "" ]]
    then
      #1 call ping command with parameters
      bash -c "echo -e 'at:$(date +%s)'&&ping -c 1 -W 2 $host">~/requestResult.txt
      #cat ~/requestResult.txt
      #2 parse and format result,write to stdout
      requestSucceeded=0
      dateNTimeOfRequest=0
      #echo "result1:$?"
      if [[ $? == "0" ]]
      then
        requestSucceededStr=$(cat ~/requestResult.txt|grep -E "\,([ ]){1,1}([0-9]){1,}([ ]){1,1}received"|awk  '/([0-9])+/{print($4)}'|awk '$1=$1')
        requestSucceeded=$(
        if [[ $requestSucceededStr == "1" ]]
        then
          echo $requestSucceededStr
          #cat ~/requestResult.txt|grep -oP '(?<=time=)\d+(\.\d+)?'
        else
          echo "0"
        fi)
        #echo "result2:$requestSucceededStr"
        dateNTimeOfRequest=$(cat ~/requestResult.txt|grep  -E "at:([0-9])+"|awk  -F ":" '{print $2}'|awk '$1=$1')
        #echo "result3:$dateNTimeOfRequest"
        #Test result for <HOST or IP> is <0 or 1> at <TIME in nanoseconds>
        #export RESULT="\"Test result for ${host} is ${requestSucceeded} at ${dateNTimeOfRequest}\""
        #echo "$RESULT"|sed -e 's/\"//g'
        export RESULT="$requestSucceeded"
        echo "Test result for ${host} is ${requestSucceeded} at ${dateNTimeOfRequest}"
        export TESTED_HOST="${host}"
        export TEST_TIMESTAMP="${dateNTimeOfRequest}"
        curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
      fi

      
      #3save to data storages
    else
      :
    fi
  done
  (( i= i + 1 ))
  #echo "Next outer loop counter $i"
  sleep "$TEST_PERIODICITY"
done
