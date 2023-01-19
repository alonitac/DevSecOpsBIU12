#!/bin/bash
#inside .bash_profile no shabang needed
#but for the sake of compatibitlity with ordinary shell script file placed
#at start
function filePermissionWarningMsg(){
  TEMP_FILE=$1
  if [  -f $TEMP_FILE ];then
  FILE_PERM=$(stat -c "%a" "$TEMP_FILE")

    if [[ $FILE_PERM != "600" ]]; then echo "Warning: $TEMP_FILE file has too open permissions"
    fi
  fi
}

function mainExercise(){
echo "Hello "$USER
#? Next one to run and check
/usr/lib/update-notifier/apt-check --human-readable
TEMP_FILE=/home/$USER/.token
#if [ ! -f $TEMP_FILE ];then
# touch $TEMP_FILE
#fi
touch $TEMP_FILE
filePermissionWarningMsg $TEMP_FILE
export COURSE_ID="devsecops12"
#echo $COURSE_ID
#Running test
#sudo adduser --quiet user3
#su -l user3
}
function  additionalExercise() {
  #optional checked and that worked
hasZsh=$(cat /etc/shells|echo|grep zsh|wc  -c)

isSudoUser=$(groups|grep sudo|wc -c)

if [[ $isSudoUser != "0" && "$USER" == "victor" &&  $hasZsh == "0" ]];then
	echo "You $USER haven't installed zsh yet.Want to try(Yes/No)"
	read answer
	echo $answer
	if [ "$answer" == "Yes" ];then

		sudo apt-get install zsh
	fi
fi

}
mainExercise
#additionalExercise

