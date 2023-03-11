TEST_PERIODICITY=5

#!/bin/bash

# Define constants
HOSTS_FILE="hosts"
TEST_PERIODICITY=5
DB_USERNAME="admin"
DB_PASSWORD="12345678"

# Iterate forever
while true; do

  # Iterate over the lines of the hosts file
  while read line; do
    # Trim leading/trailing whitespace
    line="$(echo -e "${line}" | tr -d '[:space:]')"
    if [ ! -z "${line}" ]; then
      # Ping the host and get the result
      if ping -c 1 -W 2 "${line}" > /dev/null 2>&1; then
        result=1
      else
        result=0
      fi

      # Print the test result to stdout
      echo "Test result for ${line} is ${result} at $(date +%s%N)"

      # Write the test result to InfluxDB
      TESTED_HOST="$line" RESULT="$result" TEST_TIMESTAMP="$(date +%s%N)" \
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' \
        -u $DB_USERNAME:$DB_PASSWORD \
        --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
    fi
  done < "${HOSTS_FILE}"

  # Wait for the next iteration
  sleep ${TEST_PERIODICITY}
done
