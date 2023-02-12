TEST_PERIODICITY=5

while true
do
  while read -r SERVER
  do
   status_server=$(ping  -c 1 -W 2 "$SERVER"  | grep -oP '(?<=time=)\d+(\.\d+)?')
   if [[ "$status_server" = "" ]]; then
     SUCCESS=0
   else
     SUCCESS=1
   fi
   echo $status_server
   TIME=$(date +%s)
   echo "Test result for $SERVER is $SUCCESS at $TIME"
  done < hosts
  sleep "$TEST_PERIODICITY"
done


