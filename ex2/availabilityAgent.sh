TEST_PERIODICITY=5
DB_USERNAME=admin
DB_PASSWORD=12345678

while true
do
        # read hosts
        while read -r host;
        do
                p_result=$(ping -c 1 -W 2 "$host" | grep -oP '(?<=time=)\d+(\.\d+)?')
                edt=$(date +%s)
                if [[ $? -eq 0 ]]; then
                        r_status=1
                else
                        r_status=0
                fi
                echo "Test result for $host is $r_status at $edt"

                #Populate influxdb table hosts_metrics
                curl -X POST 'http://localhost:8086/write?db=hosts_metrics' \
                -u $DB_USERNAME:$DB_PASSWORD \
                --data-binary "availability_test,host=$host value=$p_result $edt"
        done < hosts
        echo
        sleep "$TEST_PERIODICITY"
done

