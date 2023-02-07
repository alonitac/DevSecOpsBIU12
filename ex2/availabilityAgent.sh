#!/bin/bash

# Specifying the periodicity of the test
TEST_PERIODICITY=5

# Loop to repeat the test
while true
do
  # Loop to read the hosts from the file 'hosts'
  while read -r HOST
  do
    # Pinging the host and storing the exit status of the command
    ping -c 1 -W 2 $HOST > /dev/null
    EXIT_STATUS=$?

    # Printing the result of the test
    echo "Test result for $HOST is $EXIT_STATUS at $(date +%s)"

    # Storing the current timestamp
    TEST_TIMESTAMP=$(date +%s)

    # Storing the result of the ping command
    RESULT=$(ping -c 1 -W 2 $HOST | grep "received" | awk '{print $4}')

    # Checking if the result of the ping command is a valid number
    if [[ $RESULT =~ ^[0-9]+$ ]]; then
      # Setting the environment variables for InfluxDB username and password
      export DB_USERNAME=admin
      export DB_PASSWORD=12345678

      # Writing the result to InfluxDB
      curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u "$DB_USERNAME:$DB_PASSWORD" --data-binary "availability_test,host=$HOST value=$RESULT $TEST_TIMESTAMP"
    else
      echo "Invalid result for host $HOST: $RESULT"
    fi
  done < hosts

  # Sleeping for the specified periodicity
  sleep "$TEST_PERIODICITY"
done


