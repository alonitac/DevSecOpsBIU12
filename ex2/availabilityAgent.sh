TEST_PERIODICITY=5

while true
do
  # Your code here....
  cat ./hosts | while read line
    do
      ping -c $line; echo $?
    done
  sleep "$TEST_PERIODICITY"
done
