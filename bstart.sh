#!/bin/bash
dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'
#extTIME=6

results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")
if [[ "$result" != "" ]]
then
  echo "found link"

wget -O live.m3u8 "$dURL" > /root/lingkong/log.txt

extTIME=`awk 'NR==5 {print $k}' /root/lingkong/live.m3u8`;

let extTIME=`echo "$extTIME" | tr -cd "[0-9]"`/1000

extCOUNTS=`grep -o ts live.m3u8 | sort |uniq -c | tr -cd "[0-9]"`

let extTIMES="$extTIME"*"$extCOUNTS"

else
  echo "invalid URL"
  kill $$
fi

save(){
sh /root/lingkong/bend.sh
echo "catch finished"
kill $$
}


echo "start"

if [ ! -n "$1" ]; then
#parttime为空

echo "keep mode"
bmode="true"

else

#parttime非空
sleep $1 

bmode="false"

save

# > /root/lingkong/log.txt 2>&1 

fi &




#循环获取m3u8源文件
while [ "$bmode" = "true" ]
   do 
echo "catching.."

if ["$bmode" = "false"]
then
break
fi

      sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 &
      #休眠时间
      sleep "$extTIME"

   done


echo "5"



 

