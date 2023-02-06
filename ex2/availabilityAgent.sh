TEST_PERIODICITY=5

while true
do
  while read -r HOST
  do
    ping -c 1 -W 2 $HOST > /dev/null
    echo "Test result for $HOST is $? at $(date +%s)"
  done < hosts
  sleep "$TEST_PERIODICITY"
done