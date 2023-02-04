#!/bin/bash

TEST_PERIODICITY=5

while true
do

  # Your code here....
  #Read host file and perform ping while printing the result to stdout
while read line; do
 ping -c 1 -W 2  "$line"
done < hosts

  sleep "$TEST_PERIODICITY"
done
