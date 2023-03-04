#!/bin/bash

LOCK_TTL=600
HALL_CAPACITY=300

function redis-do {
  echo "$1" | redis-cli -u redis://localhost:6378/0
}

# This func verifies whether the seat number that has been chosen is valid (Place between 1 to HALL_CAPACITY)
# If not, the program exits with status 5
function seat_validation_check {
  local seat=$1
  if [[ ! "$seat" -lt "$HALL_CAPACITY" ]]; then
    echo "The seat you've chose is not valid. Please choose seat from 1 to $HALL_CAPACITY."
    exit 5
  fi
}

# This function lock a name ($2, string) and seat ($3, integer) in show ($1, string).
#
function lock {
  local show=$1
  local name=$2
  local seat=$3

  # The seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5
  seat_validation_check "$seat"

  # Get ticket statuses
  local ticket="$show:$seat"
  local book_status="$(redis-do "smembers $ticket:book")"
  local lock_status="$(redis-do "get $ticket")"

  # If this seat is already booked, print "Locking failed, seat is already booked"
  if [[ ! -z "$book_status" ]]; then
    echo "Locking failed, seat is already booked"

  # If this seat was locked by another customer, print "This seat is currently locked by other customer, try again later"
  elif [[ "$lock_status" != "$name" && ! -z "$lock_status" ]]; then
    echo "This seat is currently locked by other customer, try again later"

  # Locking is possible only if this seat was not locked by other customer name.
  else
    # The lock should be expired automatically after $LOCK_TTL seconds.
    redis-do "set $ticket $name ex $LOCK_TTL" &> /dev/null
    # Add the ticket to the "lock" set (For the reset function)
    redis-do "sadd $show:lock $ticket" &> /dev/null
    # Upon success, print "The seat was locked"
    echo "The seat was locked"
  fi
}

# This function book a name ($2, string) and seat ($3, integer) in show ($1, string).
#
function book {
  local show=$1
  local name=$2
  local seat=$3

  # The seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5
  seat_validation_check "$seat"

  # Get ticket statuses
  local ticket="$show:$seat"
  local book_status="$(redis-do "smembers $ticket:book")"
  local lock_status="$(redis-do "get $ticket")"

  # If this seat is already booked, print "Locking failed, seat is already booked"
  if [[ ! -z "$book_status" ]]; then
    echo "Locking failed, seat is already booked"

  # If the customer was not locked this seat before, print "Booking failed, please lock the seat before"
  elif [[ -z "$lock_status" || "$lock_status" != "$name" ]]; then
    echo "Booking failed, please lock the seat before"

  # Booking is possible only if $2 was locked the seat before for this show.
  else
    # Add the the name of the user to the "book" set
    redis-do "sadd $ticket:book $name" &> /dev/null
    # Remove the ticket from the "lock" set (For the reset function)
    redis-do "srem $show:lock $ticket" &> /dev/null
    # Upon success, print "Successfully booked this seat!"
    echo "Successfully booked this seat!"
  fi
}


# This function releases a lock of name ($2), seat ($3) for show ($1).
#
function release {
  local show=$1
  local name=$2
  local seat=$3

  # The seat number must not exceed HALL_CAPACITY, otherwise the program exits with status 5
  seat_validation_check "$seat"

  # Get the ticket status
  local ticket="$show:$seat"
  local lock_status="$(redis-do "get $ticket")"

  # If this seat was not locked, or was locked by another customer, the function does nothing.
  if [[ $lock_status = "$name" ]]
  then
    # Remove the "lock" status
    redis-do "del $ticket" &> /dev/null
    # Remove the ticket from the "lock" set (For the reset function)
    redis-do "srem $show:lock $ticket" &> /dev/null
    # If the seat has been released, print "The seat was released"
    echo "The seat was released"
  fi
}

# OPTIONAL
# This function releases all existed locks for show ($1).
function reset {
  local show=$1

  # Get the values of the "lock" set (The tickets info)
 # TODO Good choice of Redis command
  get_lock_keys="$(redis-do "smembers $show:lock")"

  # Release those tickets
  for key in "$get_lock_keys"
  do
    redis-do "del $key" &> /dev/null
  done

  # Reset the "lock" set (Empty the tickets info of the "lock" set)
  redis-do "unlink $show:lock" &> /dev/null
}


if [[ "$1" = "book" ]]; then
  book "${@:2}"
elif [[ "$1" = "lock" ]]; then
  lock "${@:2}"
elif [[ "$1" = "release" ]]; then
  release "${@:2}"
elif [[ "$1" = "reset" ]]; then
  reset "${@:2}"
fi