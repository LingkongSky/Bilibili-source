#!/bin/bash

bmode="true"
dURL='www.nijigaku.club'
#extTIME=6

results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")
bmode="true"

cd /root/lingkong/video

while true
   do 
echo "catching.."

      
      #休眠时间
      sleep "5"

   done &

cd ../

echo "over"


kill $$ &