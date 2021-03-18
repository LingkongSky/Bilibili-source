#!/bin/bash

cd ${bchPATH}
source ${bchPATH}/setting

mkdir video >> log.txt 2>&1
declare -x bstart_id="$$"

cid=`cat target`

curl -G -s 'http://api.live.bilibili.com/room/v1/Room/room_init' \
--data-urlencode "id=${cid}"  > info
declare -x uid=`jq -r .data.uid info`

curl -G -s 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info
liveStatus=`jq -r  .data.live_room.liveStatus info`

rm -f info

if [[ "${liveStatus}" = "1" ]]; then

curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 
jq -r .data.durl[0].url web.json > durl.txt
declare -x dURL=`cat durl.txt`
rm -f durl.txt

declare -x mainURL=`echo ${dURL%live_*}`

touch run.txt

else 

#url无效，结束程序
  echo "invalid URL"
  exit 1

fi
  

declare -x timenow1=`date +%m-%d_%H-%M`
declare -x bname1="$timenow1"."${Vtype}"

#start提示信息
echo -e "\033[32mstart \n$timenow1 \033[0m"


#循环获取m3u8源文件
while [[ -f "run.txt" ]]
   do 
echo "catching.."



###抓取文件尺寸上限设定

sizeG=`du -h -d0 video/ | grep "G"`
sizeX=`du -h -d0 video/ | grep [.]`
if [[ "$sizeX" != "" ]]
then
let size=`du -h -d0 video/ | tr -cd "[0-9]"`/10
else
size=`du -h -d0 video/ | tr -cd "[0-9]"`
fi

if [[ "$sizeG" != "" ]] && [[ "$size" -gt "10" ]]
then
echo "$size""   a   ""$sizeX""   a   ""$sizeG"
du -h -d0 video/ 
echo "touch max size"
sh bend.sh
wait
echo "result saved"
rm -f run.txt
kill -s 9 "$catch_id" >> log.txt 2>&1
kill -s 9 $$ 
fi



#链接检测
if [[ "$results" == "" ]]
then
###中途换源
curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 

jq -r .data.durl[0].url web.json > durl.txt
export dURL=`cat durl.txt`
rm -f durl.txt

declare -x mainURL=`echo ${dURL%live_*}`

results=`curl "${dURL}" 2>&1|grep EXTM3U`

#链接检测
if [[ "$results" == "" ]] 
then

#url无效，结束程序
echo "found stop"
sh bend.sh
wait
echo "result saved"
rm -f run.txt
kill -9 "$catch_id" >> log.txt 2>&1
kill -s 9 $$

fi

fi

echo 2
      sh catch.sh &
      #休眠时间
sleep 1

   done &



times="0"
if [[ -n "$catchTime" ]]; then 
MaxTimes="$catchTime"
else
#MaxTimes="$MaxTime"
MaxTimes=10
fi

while [[ "$times" -lt "$MaxTimes" ]]
do

if [[ ! -f "run.txt" ]]
then
exit 0
fi

let times+=1
sleep 1

done


rm -f run.txt
if [[ -n "$catch_id" ]]; then
wait "$catch_id"
fi 

sh bend.sh

if [[ -n "$bend_id" ]]; then
wait "$bend_id"
fi 


cd ../

unset catchTime

exit 0

