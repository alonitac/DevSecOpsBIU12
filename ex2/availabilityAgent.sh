TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"

# While loop read the each line in hosts
while true
do
  while read  HOSTS
    do
      TEST_TIMESTAMP=$(date +%s%N)
      ping -c 1 -W 2 "$HOSTS" > /dev/null
      if [ $? != 0 ]
        then
          RESULT="0"
        else
          RESULT="1"
      fi

#InfluxDB instance running
      curl -X POST 'http://localhost:8086/query' -u admin:12345678 --data-urlencode "q=CREATE DATABASE hosts_metrics"

# Print the test result to stdout
      echo "Test result for $HOSTS is $RESULT  at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$HOSTS value=$RESULT $TEST_TIMESTAMP"
    done < hosts
    echo
# Wait for the next ping
  sleep "$TEST_PERIODICITY"


done