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

declare -x dURL='https://d1–cn-gotcha108.bilivideo.com/live-bvc/371036/live_8041389_7371643.m3u8?cdn=cn-gotcha08&expires=1611644040&len=0&oi=3748178516&pt=h5&qn=10000&trid=a17e09502546452490842bb7b033a676&sigparams=cdn,expires,len,oi,pt,qn,trid&sign=1915916992f59b99f97b496eb0d4a65c&ptype=0&src=8&sl=1&order=1'
mainURL=`echo ${dURL%live_*}`

awk mainURL="$mainURL" '{print mainURL$0 > "live1.m3u8"}' live1.m3u8
