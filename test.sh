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
uid=1
name=1
title=1
roomurl=1
durl=1

results=`wget -q -O- "http://api.live.bilibili.com/room/v1/Room/room_init?id=${cid}" | grep "ok"`


#链接检测
if [[ "$results" == "" ]]
then
#url无效，结束程序
echo "invalid cid"
exit 0
else
echo "200"
fi