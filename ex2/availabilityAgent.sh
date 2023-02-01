TEST_PERIODICITY=5
export DB_USERNAME="admin"
export DB_PASSWORD="12345678"
export RESULT=""
export TESTED_HOST=""
export TEST_TIMESTAMP=""
while true
do
  File="hosts"
  Lines=$(cat $File)
    for Line in $Lines
    do PingOut=$(ping -c 1 -W 2 "$Line") && TEST_TIMESTAMP="$(date +%s%N)"
    Packet=$(echo "$PingOut" |grep -o -e "1 received" -e "0 received" | grep -o -e 0 -e 1 )
    ##Test_Result="Test result for $Line $Packet at $TEST_TIMESTAMP"
    RESULT=$Packet
    TESTED_HOST=$Line

  curl -X POST 'http://localhost:8086/write?db=hosts_metrics' -u $DB_USERNAME:$DB_PASSWORD  --data-binary "availability_test,host=$TESTED_HOST value=$RESULT $TEST_TIMESTAMP"
done
sleep "$TEST_PERIODICITY"
done
