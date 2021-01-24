#!/bin/bash

timenow=`date +%m%d%H%M`
echo "$timenow"



:<<EOF
urlTEST=`wget --spider https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8 2>&1|grep 200`


result=$(echo $urlTEST | grep "200")
if [[ "$result" != "" ]]
then
  echo "包含"
else
  echo "不包含"
fi
EOF



cid=8434843448
uid=11191432
name=1
title=1
roomurl=1
durl=1

curl -G -s 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info

name=`jq -r  .data.name info`
title=`jq -r  .data.live_room.title info`
roomid=`jq -r  .data.live_room.roomid info`
cid=`jq -r  .data.live_room.roomid info`
roomurl=`jq -r  .data.live_room.url info`

liveStatus=`jq -r  .data.live_room.liveStatus info`

#####主要下载链接获取
curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=10112" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 

jq -r .data.durl[1].url web.json > durl.txt
durl=`cat durl.txt`
durl=`echo ${durl%%.m3u8*}`
durl=`echo ${durl##*bvc}`

declare -x durl="$mainURL""$durl"'.m3u8'
