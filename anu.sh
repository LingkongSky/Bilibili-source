cd ${bchPATH}

####
results=`wget --spider "http://api.bilibili.com/x/space/acc/info?mid=${uid}"  2>&1|grep 200`

result=$(echo "$results" | grep "200")

#链接检测
if [[ "$result" == "" ]]
then
#url无效，结束程序
echo "invalid uid"
exit 0
fi

curl -G 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info

name=`jq -r  .data.name info`
title=`jq -r  .data.live_room.title info`
cid=`jq -r  .data.live_room.roomid info`
roomurl=`jq -r  .data.live_room.url info`



mainURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc'


touch durl.txt

curl -G 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json

jq -r .data.durl[1].url web.json > durl.txt

durl=`cat durl.txt`  >> log.txt

durl=`echo ${durl%%.m3u8*}` >> log.txt

durl=`echo ${durl##*bvc}` >> log.txt
declare -x durl="$mainURL""$durl"'.m3u8'

####目标链接检测
results=`wget --spider "$durl"  2>&1|grep 200`

result=$(echo "$results" | grep "200")


#链接检测
if [[ "$result" == "" ]]
then
#url无效，结束程序

echo -e "\033[31mLink can't found\033[0m"

exit 0
fi





echo -e "\033[32mname: ${name} \nuid: ${uid}\nlive_title: ${title} \ncid: ${cid} \nroom_url: ${roomurl}\033[0m"

echo "$durl"

#echo "$durl"
echo -e "\033[32mUrl analysis sucssessed\033[0m"


rm -f info
rm -f durl.txt



cd ../