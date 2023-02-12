TEST_PERIODICITY=5
export DB_USERNAME=admin
export DB_PASSWORD=12345678
while true
do
  while read -r TESTED_HOST
  do
   status_server=$(ping  -c 1 -W 2 "$TESTED_HOST"  | grep -oP '(?<=time=)\d+(\.\d+)?')
   echo $status_server
   if [[ "$status_server" = "" ]] ; then
     RESULT=0
   else
     RESULT=$status_server
   fi
   TEST_TIMESTAMP=$(date +%s)
   echo "Test result for $TESTED_HOST is $RESULT at $TEST_TIMESTAMP"
   curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done < hosts
  sleep "$TEST_PERIODICITY"
done

