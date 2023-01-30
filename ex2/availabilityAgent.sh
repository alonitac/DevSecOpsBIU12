#!/bin/bash
TEST_PERIODICITY=5
DB_USERNAME=admin
DB_PASSWORD=12345678
#!/bin/bash
TEST_PERIODICITY=5
while true; do
  for TESTED_HOST in $(cat hosts); do
    TEST_TIMESTAMP=$(date +%s%N)
    RESULT=$(ping -c 1 -W 2 "$TESTED_HOST" | grep "1 received")
    if [ -n "$RESULT" ]; then
      result=1
    else
      result=0
    fi
    echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
    curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    echo "WELL DONE!!! you've passed all tests!"
  done < hosts
  sleep $TEST_PERIODICITY
done



echo "WELL DONE!!! you've passed all tests!"