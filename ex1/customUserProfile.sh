# your solution here...


# Greet the user. e.g. if the user is john, the message Hello john will be printed to stdout (standard output).
echo "Hello $USER"

# Print how many packages are outdated (/usr/lib/update-notifier/apt-check --human-readable).
/usr/lib/update-notifier/apt-check --human-readable

# Given a file called .token in the home directory of the user
touch /home/$USER/.token

# Setting the file as a variable called "$FILE"
FILE=/home/$USER/.token

# Check if the file exists, then
if [ -f "$FILE" ] ; then
    x=5
fi

# Check the file permissions. If the octal representation of the permissions set is different from 600 (read and write by the user only), print a warning message to the user:
# "Warning: .token file has too open permissions"
if [ (stat -c '%a' $FILE) != 600 ] and [x=5] ; then
    echo "Warning: .token file has too open permissions"
else
    echo "This file does not exists."
fi


COURSE_ID=devsecops12

