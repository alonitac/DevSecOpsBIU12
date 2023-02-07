TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"


while true
do
 cat hosts | while read TESTED_HOST ;
    do

        if ping -c 1 -w 2 $TESTED_HOST > /dev/null; then
       TEST_TIMESTAMP=$( date +%s )
          echo "Test result for $TESTED_HOST is 1 at $TEST_TIMESTAMP "
          RESULT=1
          curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
          sleep 2
      else
         echo "Test result for $TESTED_HOST is 0 at $TEST_TIMESTAMP"
         RESULT=0
         curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"

        fi

    done

  echo
  sleep "$TEST_PERIODICITY"
done
