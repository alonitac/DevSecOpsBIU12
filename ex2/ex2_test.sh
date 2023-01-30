set -e

# create a db
echo "DROP db if exists"
curl --fail -XPOST http://localhost:8086/query -u $DB_USERNAME:$DB_PASSWORD --data-urlencode "q=DROP DATABASE hosts_metrics"

echo "Create hosts_metrics database"
curl --fail -XPOST http://localhost:8086/query -u $DB_USERNAME:$DB_PASSWORD --data-urlencode "q=CREATE DATABASE hosts_metrics"

echo "Run student script for 30 seconds"
chmod +x ./availabilityAgent.sh
./availabilityAgent.sh &

# wait for the availability tests to be performed at least 3 times
sleep 30

# get the tests data from influx
echo "fetch availability test results from the db"
DATA=$(curl --fail -G 'http://localhost:8086/query?pretty=true&db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD -H "Accept: application/csv" --data-urlencode "q=SELECT * FROM \"availability_test\"")


echo -e "\n\nYour test data as found in InfluxDB:\n\n$DATA\n\n"

if ! echo "$DATA" | grep -q 'name,tags,time,host,value'; then
  >&2 printf "Bad db columns. Expected 'name,tags,time,host,value'"
  exit 1
fi


if ! echo "$DATA" | grep -q "availability_test"; then
  echo "Bad measurement name. Expected 'availability_test'"
  exit 1
fi

for i in "127.0.0.1,([1-9][0-9]*|0)?(\\.[0-9]+)?" "_gateway,0" "google.com,0" "10.0.0.34,0"
do
  RES_LINES=$(echo "$DATA" | grep -E $i | wc -l)
  IFS=',' read -ra SINGLE_TEST_DATA <<< "$i"
  if ((RES_LINES < 3)); then
    echo "Bad test results for ${SINGLE_TEST_DATA[0]}. Expected at least 3 availability test with result  ${SINGLE_TEST_DATA[1]}."
    exit 1
  fi
done

echo "WELL DONE!!! you've passed all tests!"