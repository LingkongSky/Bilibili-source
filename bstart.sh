#!/bin/bash

bmode="true"
echo "start"







eoftime=6

if [ ! -n "$1" ]; then
#parttime为空
xxxxx=null

echo "keep mode"

bmode="false"

else

#parttime非空
sleep $1 

bmode="false"

sh /root/lingkong/bend.sh
# > /root/lingkong/log.txt 2>&1 
echo "catch finished"

kill $$

fi &



while (("$bmode" ==  "true"))
   do 
echo "catching..
"
      sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 &

      sleep "$eoftime"s

   done

echo "5"



 

