#!/bin/bash

########### Config
# User and Password for AUTH
# Wait time before asking for next print job
# Line Width in Chars for paper type

api_user="admin"
api_password="password"

declare -i line_width=10

echo "How long shall I wait to ask again?"
read wait_time

echo "How many chars fit in one line?"
read line_width

while : 
do 
x=$(curl -s http://localhost:3000/jobs/show.text -u "$api_user:$api_password")
# IF X IS EASTER EGG OR EMPTY, do NOTHING and just loop around
echo "Current Job: $x"
i=0
while [ $i -lt ${#x} ]; do y[$i]=${x:$i:1};  i=$((i+1));done
char_count=`expr $line_width`
for key in "${!y[@]}" 
do 
  echo "$key ${y[$key]}"
  # if key == a || A 
  # echo "out" > /sys/class/gpio/gpio4/direction
  # echo "1" > /sys/class/gpio/gpio4/value
  # echo "GPIO 4 Turned On"
  # DELAY
  # echo "0" > /sys/class/gpio/gpio4/value

  char_count=`expr $char_count - 1`
  if [ $char_count == 0 ]
  then
    echo "-----CARTRIGE RETURN + NEW LINE-----------"
    char_count=`expr $line_width`
  fi 
done

echo "-----CARTRIGE RETURN - MAYBE NOT FULL WAY! + NEW LINE-----------"
sleep $wait_time

done