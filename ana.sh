
mainURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc'
cd ${bchPATH}

touch durl.txt


if [[ "$anmode" == "cid" ]]
then

####
results=`wget -q -O- "http://api.live.bilibili.com/room/v1/Room/room_init?id=${cid}" | grep "ok"`

#链接检测
if [[ "$results" == "" ]]
then
#url无效，结束程序
echo "invalid cid"
exit 0
fi


curl -G -s 'http://api.live.bilibili.com/room/v1/Room/room_init' \
--data-urlencode "id=${cid}"  > info

uid=`jq -r .data.uid info`


fi





curl -G -s 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info

name=`jq -r  .data.name info`
title=`jq -r  .data.live_room.title info`
roomid=`jq -r  .data.live_room.roomid info`
cid=`jq -r  .data.live_room.roomid info`
roomurl=`jq -r  .data.live_room.url info`

liveStatus=`jq -r  .data.live_room.liveStatus info`

#####主要下载链接获取
curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 

jq -r .data.durl[1].url web.json > durl.txt
durl=`cat durl.txt`
durl=`echo ${durl%%.m3u8*}`
durl=`echo ${durl##*bvc}`

declare -x durl="$mainURL""$durl"'.m3u8'

####目标链接检测
:<<EOF
results=`wget --spider "$durl" 2>&1|grep 200`

result=$(echo "$results" | grep "200")

#链接检测
if [[ "$result" == "" ]]
then
#url无效，结束程序
echo -e "\033[31mm3u8Link can't found\033[0m"
exit 0
fi

EOF






if [[ "${liveStatus}" == "1" ]]; then
living="on"
else
living="off"
fi


echo -e "\033[32mname: ${name} \nuid: ${uid}\nlive_title: ${title} \ncid: ${cid} \nroom_url: ${roomurl} \nlive: ${living}\033[0m"

echo -e "\033[34mSource url: \n${durl}\033[0m"

echo -e "\033[32mUrl analysis sucssessed\033[0m"


#echo -e "}\n" '"u'${cid}'": {' "\n"  '"name":' '"'${name}'",\n'  '"uid":' '"'${uid}'",\n'  '"title":' '"'${title}'",\n'  '"cid":' '"'${cid}'",\n'  '"liveurl":' '"'${roomurl}'",\n'  '"m3u8url":' '"'${durl}'"\n}'


retest=`cat user_data 2>>/dev/null | grep "}"`
if [[ "$retest" == "" ]]; then
echo -e "{\n\n}" > user_data
echo -e "\033[32mCreate new user_data\033[0m"
fi 


retest1=`jq ".u${cid}" user_data`

if [[ ! "$retest1" == "null" ]] && [[ ! "$retest1" == "" ]]; then
echo "The user had already input"

else

exist=`cat user_data | grep "a"`

if [[ ! "$exist" == "" ]]; then

echo "input new data"

echo -e '"u'${cid}'": {' "\n"  '"name":' '"'${name}'",\n'  '"uid":' '"'${uid}'",\n'  '"title":' '"'${title}'",\n'  '"cid":' '"'${cid}'",\n'  '"liveurl":' '"'${roomurl}'",\n'  '"m3u8url":' '"'${durl}'"\n},\n' > user_json

else

echo "create new data"
echo -e '"u'${cid}'": {' "\n"  '"name":' '"'${name}'",\n'  '"uid":' '"'${uid}'",\n'  '"title":' '"'${title}'",\n'  '"cid":' '"'${cid}'",\n'  '"liveurl":' '"'${roomurl}'",\n'  '"m3u8url":' '"'${durl}'"\n}\n' > user_json

fi

sed -i '2 r user_json' user_data 
format=`jq . user_data`
echo -e "$format" > user_data
fi

rm -f user_json
rm -f info
rm -f durl.txt


cd ../