#TEST_PERIODICITY=5



#! /bin/bash


TEST_PERIODICITY=5




function ping_check {


    if [[ "$1" == "" ]]; then
        return 1
    fi


    __RESULT=$(ping $1 -c 1 -W 2 2>/dev/null)
    if [[ "$?" != "0" ]]; then
         return 1
    fi


    echo "$__RESULT" | grep -oP '(?<=time=)\d+(\.\d+)?'| awk '{print $1*1000}'
}

function execute_check {

    # Check if the input is empty.
    # If varable is empty the function exit with code 1
    if [[ "$1" == "" ]]; then
        return 1
    fi

    # Performing ping check for the given address.
    # Store the result in DB. If DB not avaliable print to screen
    RESULT=$(ping_check "$1")
    STATUS="$?"
    RESULT="${RESULT:=0}"
    curl -X POST "http://localhost:8086/write?db=hosts_metrics" \
         -u "admin":"12345678" \
         --data-binary "availability_test,host=$1 value=$RESULT $(date +'%s%N')" 2> /dev/null
    POST_RESULT=$?
    if [[ "$POST_RESULT" != "0" ]]; then
        echo "Test result for $1 is $STATUS at $(date +'%s%N')"
    fi
}

hosts=$(cat ./hosts)

while true
do
    for host in $hosts; do
        execute_check "$host" &
    done
    sleep "$TEST_PERIODICITY"
done



#while true
#do
  #while read line; do
  # ping -c 1 -w 2 "$line" &> /dev/null
#if  [ $? -eq 0 ]; then
  #echo "test result for $line is 1 at $(date +%s%N)"
#if  [ $? -eq 0 ]; then
     #curl -X POST "http://localhost:8086/write?db=hosts_metrics" -u "admin":"12345678" --data-binary "availability_test,host=$1 value=$? $(date +'%s%N')"
#fi
# echo "test result for $line is 0  at $(date +%s%N)"

#sleep "$TEST_PERIODICITY"
#  done < hosts
#done

#gnome-terminal
#docker run --rm --name influxdb -p 8086:8086 -e INFLUXDB_ADMIN_USER=admin -e INFLUXDB_ADMIN_PASSWORD=12345678 -e INFLUXDB_HTTP_AUTH_ENABLED=true influxdb:1.8.10
#gnome-terminal
#curl -X POST 'http://localhost:8086/query' -u admin:12345678 --data-urlencode "q=CREATE DATABASE hosts_metrics"
#gnome-terminal
##ocker run --rm --name grafana -e "GF_SERVER_HTTP_PORT=3003" --network host grafana/grafana-oss


