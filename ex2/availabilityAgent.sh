TEST_PERIODICITY=5

while true
do
  File="hosts"
  Lines=$(cat $File)
   for Line in $Lines
   do PingOut=$(ping -c 1 -W 2 "$Line")
   Packet=$(echo "$PingOut" |grep -o -e "1 received" -e "0 received" | grep -o -e "0" -e "1" )
   Test_Result=$(echo Test result for "$Line" is "$Packet" at "$(date +%s%3N)" )
   echo "$Test_Result"
   done
  sleep "$TEST_PERIODICITY"
done
