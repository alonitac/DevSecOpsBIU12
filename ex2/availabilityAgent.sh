TEST_PERIODICITY=5

while true
do
  while true; do
    # read each line of the hosts file
    while read host; do
     # run the ping command
    result=$(ping -c 1 -W 2 $host | tail -1)

    # extract the result of the ping
  if echo $result | grep -q "1 received"; then
      # ping received, set result to 1
      # ping failed, set result to 0
      result=0
    else
       # ping received, set result to 1
      result=1
    fi

  # get the current timestamp in nanoseconds
  timestamp=$(date +%s%N)

  # write the test result to stdout
  echo "Test result for $host is $result at $timestamp"
  TESTED_HOST=$hosts
  RESULT=$result
  TEST_TIMESTAMP=$timestamp
  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
  done < hosts

  # wait for TEST_PERIODICITY seconds before executing the loop again
  sleep "$TEST_PERIODICITY"

done

done

