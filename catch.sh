#!/bin/bash

A="Done"

cd /root/lingkong/


touch live.m3u8

#下载主文件
wget  --wait=6 -O live.m3u8 --tries=2 https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8

#提取下载文件内容输入主文件

sed -n '/ts/w live1.m3u8' live.m3u8

#给主文件添加前缀
awk '{print "https://cn-jxnc-cmcc-live-01.bilivideo.com"$0 > "live1.m3u8"}' live1.m3u8

wget -i live1.m3u8  --unlink -P video/



list_name=`ls video/*.ts`


for file in video/*.ts; do F="$(echo $file |sed 's/ts$/mp4/g')"; ffmpeg -i $file $F; done


if [ -f "video/*.ts" ];then 
mv video/*.ts ts/;
fi



cd ../
#node lookfor.js

#文件移除
rm /root/lingkong/live1.m3u8  -f
echo "$A"
echo "$list_name"
#echo "$extract"

rm /root/lingkong/ts/*.1 -f
rm /root/lingkong/live.m3u8 -f