#!/bin/bash
cd ${bchPATH}

mkdir video
#目标链接
#declare -x dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'
curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=10112" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 

jq -r .data.durl[0].url web.json > durl.txt
declare -x dURL=`cat durl.txt`
rm -f durl.txt
#declare -x dURL='http://d1–cn-gotcha105.bilivideo.com/live-bvc/615423/live_1590370_4064847.m3u8?cdn=cn-gotcha05&expires=1611761632&len=0&oi=147989512&pt=h5&qn=10000&trid=595b2d0846d14be997a50c96cc0c97c8&sigparams=cdn,expires,len,oi,pt,qn,trid&sign=445241f0cb68c7407e7c2682d102f0c8&ptype=0&src=9&sl=1&order=1'

declare -x mainURL=`echo ${dURL%live_*}`

#extTIME=6

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

size=`du -h -d0 video/ | tr -cd "[0-9]"`

#链接检测
if [[ "$results" == "" ]] || [[  "$size" > 4096 ]]
then
#url无效，结束程序
echo "found stop"
sh bend.sh
wait
echo "result saved"
exit 0
fi



      sh catch.sh 
      #休眠时间
      sleep "$extTIME"

   done &


if [ -n "$catchTime" ]; then 
sleep "$catchTime"
else
sleep 60
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


