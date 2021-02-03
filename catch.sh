#!/bin/bash

declare -x catch_id="$$"
cd ${bchPATH}/
source ${bchPATH}/setting

if [ ! -f "run.txt" ]
then 
exit 0
fi

#下载主文件
wget  --wait=5 -O live.m3u8 --tries=24 "$dURL" -N 

#提取下载文件内容输入主文件

sed -n '/ts/w live1.m3u8' live.m3u8

#给主文件添加前缀

awk '{print "'"$mainURL"'"$0 > "live1.m3u8"}' live1.m3u8


wget --limit-rate="${catch_speed}"K -c -i live1.m3u8  --unlink -P ts/ 

str=`find ts/ -name \*.*`
for i in $str
do
mv $i ${i%.*}.ts
done

mv ts/* video/
rm -rf ts

list_name=`ls video/*.ts`


if [[ ! "$list_name" =~ "ts" ]];then
put_path=$(cd `dirname $0`; pwd)
echo -e "\033[31mWithout found the target ts in $put_path/video\033[0m"
exit 0
fi


for file in video/*.ts; do F="$(echo $file |sed 's/ts$/mp4/g')"; ffmpeg -i $file -c copy -map 0:v -map 0:a -bsf:a aac_adtstoasc $F; done >> log.txt 2>&1

rm video/*.ts -f 

#node lookfor.js

#文件移除
rm live1.m3u8 -f 
rm live.m3u8 -f 

cd ../

echo -e "\033[32mnew ts: \n${list_name}\033[0m"

echo -e "\033[32mCatch successful\033[0m"



#echo "$extract"
unset catch_id