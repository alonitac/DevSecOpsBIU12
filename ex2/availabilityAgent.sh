#!/bin/bash
TEST_PERIODICITY=5
while true; do
  for host in $(cat hosts); do
    timestamp=$(date +%s%N)
    result=$(ping -c 1 -W 2 "$host" | grep "1 received")
    if [ -n "$result" ]; then
      result=1
    else
      result=0
    fi
    echo "Test result for $host is $result at $timestamp"
    curl -i -XPOST "http://localhost:8086/write?db=hosts_metrics" \
	-u "admin:12345678" \
  --data-binary "ping_test value=$result $timestamp"
  done < hosts
  sleep $TEST_PERIODICITY
done
