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


if [ -z "$(echo $1 | sed 's#[0-9]##g')" ] && [ "$1" != "" ]; then

echo "yes"

else
echo "bch -t [time:s]"
exit 0
fi
