set -e

USER_PASS=1234

OUTPUT_FILE=terminal_output
function print_terminal_output {
  printf "\nYour terminal output after login is: \n------------------------------------\n$(cat $OUTPUT_FILE)\n------------------------------------\n\n"
}

# delete myuser if exists
rm -f -r /home/myuser
if id -u myuser &> /dev/null; then
  userdel myuser
fi

cat customUserProfile.sh > /etc/skel/.bash_profile

adduser myuser --gecos "" --disabled-password
echo "myuser:$USER_PASS" | chpasswd

echo -e "n\nCase 1: No .token file in user's home dir"

echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "touch .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Hello myuser" "$OUTPUT_FILE"; then
  >&2 printf "Bad greeting. Expected 'Hello myuser' to be found"
  exit 1
fi

if ! grep -q "updates can be applied immediately" "$OUTPUT_FILE"; then
  >&2 printf "Expected to get an outdated packages message"
  exit 1
fi

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it doesn't exist yet"
  exit 1
fi

echo -e "Case 2: .token file with bad permissions\n\n"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if ! grep -q "Warning: .token file has too open permissions" "$OUTPUT_FILE"; then
  >&2 printf "Expected a message regarding .token permissions: 'Warning: .token file has too open permissions'"
  exit 1
fi

echo -e "Case 3: .token file with right permissions\n\n"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "chmod 600 .token" > $OUTPUT_FILE
print_terminal_output

if grep -q ".token" "$OUTPUT_FILE"; then
  >&2 printf "There should not be any message regarding .token file since it has good permissions set"
  exit 1
fi


echo -e "Case 4: Existed COURSE_ID env var\n\n"
echo $USER_PASS | sudo -S sleep 1 && su -l myuser -c "printenv" > $OUTPUT_FILE

if grep -q "COURSE_ID=devsecops12" "$OUTPUT_FILE"; then
  >&2 printf "Missing environment variable COURSE_ID with value 'devsecops12'"
  exit 1
fi


echo "WELL DONE!!! you've passed all tests!"