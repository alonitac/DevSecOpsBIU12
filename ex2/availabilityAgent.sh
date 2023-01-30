#!/bin/bash
while IFS="" read -r p || [ -n "$p" ]
do
  SEC=$(expr $(ping -c 1 -W 2 "$p" | sed -n 's/.*time=\(.*\) ms$/\1/p'))
  NAN=$(echo $SEC*1000000 | bc)
  if [[ $NAN ]]; then printf '%s\n' "Test result for $p is 1 at $NAN"
  else printf '%s\n' "Test result for $p is 0 at $NAN"


fi
done < hosts