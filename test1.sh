#!/bin/bash

bmode="true"

dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'

#extTIME=6

result=$(echo $dURL | grep "200")

echo "$result"


: <<EO
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

EO

echo "start"