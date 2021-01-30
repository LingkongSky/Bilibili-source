#!/bin/bash
cd ${bchPATH}
mkdir video >> log.txt 2>&1
declare -x bstart_id="$$"
#目标链接
#declare -x dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'


curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=66840" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 

jq -r .data.durl[0].url web.json > durl.txt
export dURL=`cat durl.txt`
rm -f durl.txt

declare -x mainURL=`echo ${dURL%live_*}`

results=`curl "${dURL}" 2>&1|grep EXTM3U`

#链接检测
if [[ "$results" != "" ]] 
then

wget -O live.m3u8 "$dURL" >> log.txt 2>&1

#获取单ts时间长度

extTIMES=`cat live.m3u8 | grep EXTINF > live1.m3u8 ; awk 'NR==1 {print $k}' live1.m3u8 | tr -cd "[0-9]";rm -f live1.m3u8`

extTIMES=`echo "scale=4;${extTIMES}/1000" | bc`


#获取ts个数
extCOUNTS=`grep -o ts live.m3u8 | sort |uniq -c | tr -cd "[0-9]"`

#设定循环获取请求周期
extTIME=`echo "scale=4;${extTIMES}*${extCOUNTS}" | bc`

echo -e "\033[32mcycle time:${extTIME}\033[0m"


touch run.txt

else
#url无效，结束程序
  echo "invalid URL"
  exit 1

fi


#start提示信息
echo -e "\033[32mstart \033[0m"



#循环获取m3u8源文件
while [ -f "run.txt" ]
   do 
echo "catching.."


results=`curl "${dURL}" 2>&1|grep EXTM3U`


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

#######

#链接检测
if [[ "$results" == "" ]]
then
###中途换源
curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=66840" \
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

wget -O live.m3u8 "$dURL" >> log.txt 2>&1

#获取单ts时间长度

extTIMES=`cat live.m3u8 | grep EXTINF > live1.m3u8 ; awk 'NR==1 {print $k}' live1.m3u8 | tr -cd "[0-9]";rm -f live1.m3u8`

extTIMES=`echo "scale=4;${extTIMES}/1000" | bc`


#获取ts个数
extCOUNTS=`grep -o ts live.m3u8 | sort |uniq -c | tr -cd "[0-9]"`

#设定循环获取请求周期
extTIME=`echo "scale=4;${extTIMES}*${extCOUNTS}" | bc`

fi


      sh catch.sh 
      #休眠时间
      sleep "$extTIME"




   done &

if [ -n "$catchTime" ]; then 
sleep "$catchTime"
else
sleep 1000000
fi

rm -f run.txt
if [ -n "$catch_id" ]; then
wait "$catch_id"
fi 

sh bend.sh

if [ -n "$bend_id" ]; then
wait "$bend_id"
fi 

rm -rf video
cd ../

unset catchTime


exit 0


