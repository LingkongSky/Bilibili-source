#!/bin/bash
cd ${bchPATH}

mkdir video
#目标链接
#declare -x dURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/730840/live_1590370_4064847_1500.m3u8'

declare -x dURL='http://d1--cn-gotcha105.bilivideo.com/live-bvc/208679/live_1590370_4064847.m3u8?cdn=cn-gotcha05&expires=1611705427&len=0&oi=147989512&pt=h5&qn=10000&trid=e94f53dddabc451a9f7f21452c982004&sigparams=cdn,expires,len,oi,pt,qn,trid&sign=e6dae3cd7bfb078eb4f459833a17f623&ptype=0&src=9&sl=1&order=1'
declare -x mainURL=`echo ${dURL%live_*}`
#extTIME=6




results=`curl "${durl}" 2>&1|grep EXTM3U`


#链接检测
if [[ "$results" != "" ]]
then

echo -e "\033[32mfound link \033[0m"

wget -O live.m3u8 "$dURL" >> log.txt 2>&1

extTIMES=`awk 'NR==5 {print $k}' live.m3u8`;

#获取单ts时间长度
let extTIMES=`echo "$extTIMES" | tr -cd "[0-9]"`/1000

#获取ts个数
extCOUNTS=`grep -o ts live.m3u8 | sort |uniq -c | tr -cd "[0-9]"`

#设定循环获取请求周期
let extTIME="$extTIMES"*"$extCOUNTS"

echo -e "\033[32mcycle time:${extTIME}\033[0m"

rm -f live.m3u8

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


results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")

#链接检测
if [[ "$result" == "" ]]
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
sleep 10
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


