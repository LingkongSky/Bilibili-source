#!/bin/bash

bmode="true"
dURL='www.nijigaku.club'
#extTIME=6

results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")
bmode="true"

while [ "$bmode" = "true" ]
   do 

echo "catching.."

if [ "$bmode" = "false" ] then break fi

    sleep 3

bmode="false"

done 