LOCK_TTL=600
HALL_CAPACITY=300
LOCK=1
SOLD=2
BOOK=1

function check_seat {
  local show=$1
  local name=$2
  local seat=$3
  local book=$4

  seat_name=$(echo "GET $show:$seat:$SOLD" | redis-cli -u redis://localhost:6378/0)
  if [[ "$seat_name" != 0 && "$seat_name" != "" ]]; then
   echo "Locking failed, seat is already booked"
   exit 1
  fi

  seat_name=$(echo "GET $show:$seat:$LOCK" | redis-cli -u redis://localhost:6378/0)
  if [[ "$seat_name" = "" && "$book" = 1 ]]; then
   echo "Booking failed, please lock the seat before"
   exit 1
  elif [[ "$seat_name" != "" && "$seat_name" != "$name" ]]; then
   echo "This seat is currently locked by other customer, try again later"
   exit 1
  fi
}

function lock {
  local show=$1
  local name=$2
  local seat=$3

  check_seat "$show" "$name" "$seat"

  lock_sts=$(echo "SET $show:$seat:$LOCK $name NX EX $LOCK_TTL" | redis-cli -u redis://localhost:6378/0)
  if [[ "$lock_sts" = "OK" ]] ; then
    echo "The seat was locked"
    exit 0
  elif [[ "$lock_sts" = "$name" || "$lock_sts" = "" ]]; then
    echo "The seat is locked by you already"
  fi
}

function book {
  local show=$1
  local name=$2
  local seat=$3

  check_seat "$show" "$name" "$seat" "$BOOK"

  sold_sts=$(echo "SET $show:$seat:$SOLD $name NX " | redis-cli -u redis://localhost:6378/0)
  if [[ "$sold_sts" = "OK" ]]; then
    echo "Successfully booked this seat!"
    exit 0
  fi
}

function release {
  local show=$1
  local name=$2
  local seat=$3
  seat_name=$( echo "GET $show:$seat:$LOCK" | redis-cli -u redis://localhost:6378/0)
  if [[ "$seat_name" = "$name" ]]; then
      tmp=$( echo "EXPIRE $show:$seat:$LOCK 0 " | redis-cli -u redis://localhost:6378/0 )
      echo "The seat was released"
  fi
}

function reset {
  local show=$1
  for ((i=1;i<=HALL_CAPACITY;i++)); do
    echo "GETDEL $show:$i:$LOCK " | redis-cli -u redis://localhost:6378/0
  done
}

function delete_all {
  local show=$1
  for ((i=1;i<=HALL_CAPACITY;i++)); do
     tmp=$( echo "GETDEL $show:$i:$LOCK " | redis-cli -u redis://localhost:6378/0 )
     tmp=$( echo "GETDEL $show:$i:$SOLD" | redis-cli -u redis://localhost:6378/0 )
  done
  echo ""
  echo "all seat are free for show  $show"
}


function display {
  local show=$1
  for ((i=1;i<=HALL_CAPACITY;i++)); do
    seat_name=$(echo "GET $show:$i:$SOLD" | redis-cli -u redis://localhost:6378/0)
    if [[ "$seat_name" = 0 || "$seat_name" = "" ]]; then
      seat_name=$(echo "GET $show:$i:$LOCK" | redis-cli -u redis://localhost:6378/0)
      if [[ "$seat_name" != 0 && "$seat_name" != "" ]]; then
        echo "Record - show=$show seat=$i status=LOCK name=$seat_name"
      fi
    else
       echo "Record - show=$show seat=$i status=SOLD name=$seat_name"
   fi
  done
}

#  main **

if  [[ "$4" -gt "$HALL_CAPACITY" ]]; then
    echo "wrong seat $4, only $HALL_CAPACITY seats in the Hall "
    exit 5
fi

if [[ "$1" = "book" ]]; then
  book "${@:2}"
elif [[ "$1" = "lock" ]]; then
  lock "${@:2}"
elif [[ "$1" = "release" ]]; then
  release "${@:2}"
elif [[ "$1" = "reset" ]]; then
  reset "${@:2}"
elif [[ "$1" = "display" ]]; then
  display "${@:2}"
elif [[ "$1" = "delete_all" ]]; then
  delete_all "${@:2}"
fi