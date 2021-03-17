#!/bin/bash

declare -x catch_id="$$"
cd ${bchPATH}/
source ${bchPATH}/setting
if [ ! -f "run.txt" ]
then 
exit 0
fi

#下载主文件
wget --wait=1 -O live.m3u8 --tries=60 "$dURL" -N

#提取下载文件内容输入主文件

sed -n '/ts/w live1.m3u8' live.m3u8

#给主文件添加前缀

awk '{print "'"$mainURL"'"$0 > "live1.m3u8"}' live1.m3u8

if [[ -f "download.txt" ]];
then

cat download.txt | while read lineb
  do
    cat live1.m3u8 | while read linea
      do
      
if [ "$lineb" = "$linea" ]; then
sed -i '/'"$linea"'/d' live1.m3u8
      fi
    done
  done


fi

cat live1.m3u8 >> download.txt

wget --limit-rate="${catch_speed}"K -c -i live1.m3u8  --unlink -P ts/ 


str=`find ts/ -name \*.*`
for i in $str
do
mv $i ${i%.*}.ts
done


#转移文件
#mv ts/*.ts video/
#rm -rf ts



ls  ts/*.ts > list.txt

if [ -f "${results_path}"/"$bname1" ];
then
echo "${results_path}"/"$bname1" >> list.txt
fi

#添加前缀
prefix="file '"
perfix1="'"

awk '{print "'"$prefix"'"$0}' list.txt > list1.txt

awk '{print $0"'"$perfix1"'"}' list1.txt > list.txt

rm -f list1.txt



ffmpeg -y -f concat -safe 0 -i list.txt "${results_path}"/"$bname1"

wait

:<<EOF
list_name=`ls video/*.*`

if [[ "$list_name" == "" ]];then
put_path=$(cd `dirname $0`; pwd)
echo -e "\033[31mWithout found the target file in $put_path/video\033[0m"
exit 0
fi
EOF

#文件移除
mv ts/*.ts video/
rm -f list.txt
rm live1.m3u8 -f 
rm live.m3u8 -f 

cd ../

#echo -e "\033[32mnew file: \n${list_name}\033[0m"

echo -e "\033[32mCatch successful\033[0m"


unset catch_id