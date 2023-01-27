#!/bin/bash

if ! jq &> /dev/null
then
  echo "please install jq"
  exit 1
fi


