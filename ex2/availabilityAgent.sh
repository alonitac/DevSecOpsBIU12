#!/bin/bash

TEST_PERIODICITY=5s

while true; do
  read -r line
  results=$(ping -c 1 -W 2 "$line" | awk -F '/' 'END {print $5}')
  test_results=$?
  time=$(date +%s%N)
  if [ $test_results -eq 0 ]; then
    test_results=1
  else
    test_results=0
  fi
  echo "Test result for <$line> is <$test_results> at <$time>"
  sleep $TEST_PERIODICITY
done < hosts