#! /bin/bash

# CONSTANTS
TEST_PERIODICITY=5



# Performing ping request.
# the function return:
#     Failed:	0
#     Success:	RTT (in microseconds)
function ping_check {

    # Check if the input is empty.
    # If varable is empty the function exit with error code
    if [[ "$1" == "" ]]; then
        return 1
    fi

    # Performing ping check.
    # If ping faileed, the function exit with error code
    __RESULT=$(ping $1 -c 1 -W 2 2>/dev/null)
    if [[ "$?" != "0" ]]; then
         return 1
    fi

    # Ping working. return the latency in microseconds.
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
