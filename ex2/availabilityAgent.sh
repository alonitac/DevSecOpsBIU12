#! /bin/bash

TEST_PERIODICITY=5

# Performing ping request.
# the function return:
#     Failed:	0
#     Success:	RTT (in microseconds)
function ping_check {
    if [[ "$1" == "" ]]; then
        return 0
    fi
    result=$(ping $1 -c 1 -W 2 2>/dev/null)
    if [[ "$?" != "0" ]]; then
        return 0
    fi
    return $(echo "$result" | grep -oP '(?<=time=)\d+(\.\d+)?'| awk '{print $1*1000}')
}

function execute_check {
    if [[ "$1" == "" ]]; then
        return 0
    fi
    ping_check "$1"
    result=$?
    if [[ result != "0" ]]; then
        curl -X POST "http://localhost:8086/write?db=hosts_metrics" -u "admin":"12345678" --data-binary "availability_test,host=$1 value=$result $(date +'%s%N')"
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
