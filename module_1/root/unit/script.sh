#!/bin/sh

COUNTER=0
while true
do
  echo "["$(date)"] New Line (${COUNTER})"
  ((COUNTER++))
  sleep 5
done