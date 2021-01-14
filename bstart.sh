#!/bin/bash

bmode="true"
dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'
eofTIME=6
#eofTIME=`awk 'NR==5 {print $k}' /root/lingkong/live_example.m3u8`;let eofTIME=`echo "$eofTIME" | tr -cd "[0-9]"`/1000


result=$(echo $dURL | grep "200")
if [[ "$result" != "" ]]
then
  echo "found link"
else
  echo "invalid URL"
  kill $$
fi


echo "start"


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




#循环获取m3u8源文件
while (("$bmode" ==  "true"))
   do 
echo "catching.."


      sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 &
      
      #休眠时间
     
      sleep "$eofTIME"s

   done

echo "5"



 

