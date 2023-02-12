TEST_PERIODICITY=5

while true
do
  while read line; do
   ping -c 1 -w 2 "$line" &> /dev/null
if  [ $? -eq 0 ]; then
  echo "test result for $line is 1 at $(date +%s%N)"
else
 echo "test result for $line is 0  at $(date +%s%N)"
fi
sleep "$TEST_PERIODICITY"
  done < hosts
done
# echo "test result for <$line> is <$?> at <$(date +%s%N)>"
gnome-terminal
docker run --rm --name influxdb -p 8086:8086 -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=12345678 -e INFLUXDB_HTTP_AUTH_ENABLED=true influxdb:1.8.10
gnome-terminal
curl -X POST 'http://localhost:8086/query' -u admin:12345678 --data-urlencode "q=CREATE DATABASE hosts_metrics"
gnome-terminal
curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"


  #sleep "$TEST_PERIODICITY"
 # done < hosts
#done

