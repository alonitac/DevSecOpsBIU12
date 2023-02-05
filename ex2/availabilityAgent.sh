TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"

while true
do
  while read  TESTED_HOST
    do
      TEST_TIMESTAMP=$(date +%s%N)
      ping -c 1 -W 2 "$TESTED_HOST" > /dev/null
      if [ $? != 0 ]
        then
          RESULT="0"
        else
          RESULT="1"
      fi

      #echo "$TESTED_HOST"
      echo "Test result for $TESTED_HOST is $RESULT  at $TEST_TIMESTAMP"
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    done < hosts
    echo
  sleep "$TEST_PERIODICITY"


done
