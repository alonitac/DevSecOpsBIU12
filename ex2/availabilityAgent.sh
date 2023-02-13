TEST_PERIODICITY=5

while true
do
        # read hosts
        while read -r host;
        do
                p_result=$(ping -c 1 -W 2 "$host")
                if [ $? -eq 0 ]; then
                        r_status=1
                else
                        r_status=0
                fi
                echo "Test result for $host is $r_status at $(date +%s)"
        done < hosts
        echo
        sleep "$TEST_PERIODICITY"
done

