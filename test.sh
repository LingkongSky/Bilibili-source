#!/bin/bash

timenow=`date +%m%d%H%M`
echo "$timenow"

eofTIME=`awk 'NR==5 {print $k}' /root/lingkong/live_example.m3u8`

let eofTIME=`echo "$eofTIME" | tr -cd "[0-9]"`/1000
echo "$eofTIME"
#echo "$eofTIME2"

urlTEST=`wget --spider https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8 2>&1|grep 200`


result=$(echo $urlTEST | grep "200")
if [[ "$result" != "" ]]
then
  echo "包含"
else
  echo "不包含"
fi
