#!/bin/bash

bmode="true"

if [ ! -n "$1" ]; then
#parttime为空
xxxxx=null

else

#parttime非空
sleep $1



bmode="false"
sh /root/lingkong/bend.sh > /root/lingkong/log.txt 2>&1 
echo "catch finished"
fi &

while ("$bmode" ==  "true")
   do 

      sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 

      sleep 6

   done




 

