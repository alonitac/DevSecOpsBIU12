TEST_PERIODICITY=5

while true
do
        # read hosts
        while read -r host;
        do
                p_result=$(ping -c 1 -W 2 "$host" | grep -oP '(?<=time=)\d+(\.\d+)?')
                if [[ "$p_result" -eq "" ]]; then
                        p_result=0
                fi

                #Timestamp epoch
                edt=$(date +%s)

                #Result status update
                if [[ $? -eq 0 ]]; then
                        r_status=1
                else
                        r_status=0
                fi

                #Print format to console
                echo "Test result for $host is $r_status at $edt"

                #Populate influxdb table hosts_metrics
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' \
                -u $DB_USERNAME:$DB_PASSWORD \
                --data-binary "availability_test,host=$host value=$p_result $edt"
        done < hosts
        echo
        sleep "$TEST_PERIODICITY"
done

