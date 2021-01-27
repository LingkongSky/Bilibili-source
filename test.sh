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

declare -x dURL='http://d1–cn-gotcha105.bilivideo.com/live-bvc/620187/live_1590370_4064847.m3u8?cdn=cn-gotcha05&expires=1611756921&len=0&oi=147989512&pt=h5&qn=10000&trid=55a60985dd0e448590a7585f9f56cebe&sigparams=cdn,expires,len,oi,pt,qn,trid&sign=879d462fb114aea6d4e8d6971aae1e06&ptype=0&src=9&sl=1&order=1'
mainURL=`echo ${dURL%live_*}`




awk '{print "'"$mainURL"'"$0 > "live1.m3u8"}' live1.m3u8