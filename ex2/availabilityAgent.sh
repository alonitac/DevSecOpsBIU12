#!/bin/bash

TEST_PERIODICITY=3
RESULT="Test result for"


while true
do
  # Your code here....
  # Write the result of the host file, Test result for <HOST or IP> is <0 or 1> at <TIME in nanoseconds>
IFS=''
while read line
do
  echo $RESULT $line
done < hosts
echo


  sleep "$TEST_PERIODICITY"
done
