#!/bin/bash
export DB_USERNAME=admin
export DB_PASSWORD=12345678
TEST_PERIODICITY=5

while true; do
  while read -r ip_or_host; do
   result=$(ping -c 1 -W 2 "$ip_or_host" | grep -c "1 received")
    if [ "$result" -eq 1 ]; then
      result=1
    else
      result=0
    fi
time=$(($(date +%s%N)/1000000))
echo "Test result for $ip_or_host is $result at $time"

curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$ip_or_host value=$result $time"
  done < hosts

sleep "$TEST_PERIODICITY"
done
