TEST_PERIODICITY=5

while true
do
 cat hosts | while read line ;
    do

        if ping -c 1 -w 2 $line > /dev/null; then
         TIME=$( date +%s )
          echo "Test result for $line is 1 at $TIME "
          RESULT=1
          sudo curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u admin:12345678  --data-binary "availability_test,host=$line value=$RESULT $TIME"
          sleep 2
      else
         echo "Test result for $line is 0 at $TIME"
         RESULT=0
         sudo curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u admin:12345678  --data-binary "availability_test,host=$line value=$RESULT $TIME"

        fi

    done

  echo
  sleep "$TEST_PERIODICITY"
done
