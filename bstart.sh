#!/bin/bash

bmode="true"
dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'
#extTIME=6



result=$(echo $dURL | grep "200")
if [[ "$result" != "" ]]
then
  echo "found link"

wget -O live.m3u8 "$dURL" 

extTIME=`awk 'NR==5 {print $k}' /root/lingkong/live.m3u8`;let extTIME=`echo "$extTIME" | tr -cd "[0-9]"`/1000

extCOUNTS=`grep -o ts live.m3u8 | sort |uniq -c | tr -cd "[0-9]"`

let extTIMES=extTIME * extCOUNTS

echo "extTIMES"

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

save

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
     
      sleep "$extTIME"s

   done


function save(){
  
sh /root/lingkong/bend.sh


}



echo "5"



 

