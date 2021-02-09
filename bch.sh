#!/bin/bash
local_version="1.1.4"
source /etc/profile
cd ${bchPATH}/
if [[ -f target ]];then
cid=`cat ${bchPATH}/target`
fi



case "$1" in

##########
"-v")

echo -e "\033[32mBilibili-Catch Version ${local_version} @Lingkongsky\033[0m"


test=`wget --spider https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/bch.sh > version1 2>&1`

test=`cat version1 | grep 404`

rm -f version1

if [[ "$test" != "" ]];then

wget https://smallpipe.xyz/bch/version -O version1 >> /dev/null 2>&1
else
wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/version -O version1 >> /dev/null 2>&1

fi

version=`cat version1`
rm -f version1

L1=`echo ${local_version:0:1}`
M1=`echo ${local_version:2:1}`
S1=`echo ${local_version:4:1}`
L2=`echo ${version:0:1}`
M2=`echo ${version:2:1}`
S2=`echo ${version:4:1}`

if [[ "$L1" -lt "$L2" ]] || [[ "$M1" -lt "$M2" ]] || [[ "$S1" -lt "$S2" ]];then
#检测到新版本
echo -e "\033[32mThe Last New Version: ${version}\nHave new version could update\033[0m"
echo "please enter bch -update to update"
else
echo -e "\033[32mThis is already the newst version\033[0m"
fi


echo "Program adress:"
echo -e "\033[34mhttps://github.com/LingkongSky/Bilibili-source.git\033[0m"

;;


#########
"-start")

shid=`ps -ef | grep ${bchPATH}/bstart.sh | grep -v grep`

if [[ "$shid" != "" ]]; then
echo "process already had"
exit 0
fi

wget "http://api.live.bilibili.com/room/v1/Room/playUrl?cid=${cid}&qn=10000&platform=h5" -O web.json >> log.txt 2>&1
durl=`jq -r .data.durl[0].url web.json`
rm -rf web.json
results=`curl "${durl}" 2>&1|grep EXTM3U`

if [[ "$results" == "" ]]
then
echo -e "\033[31mLive can't found\033[0m"
exit 0
fi 

bch -target
echo -e "start the BiliBili-Source-Catch "
start_time=`date +%m-%d-%H:%M`
echo -e "\033[32m${start_time}\033[0m"

#清除上一次的抓取记录
sed -i '/bst_time/d' /etc/profile
source /etc/profile

bst="export bst_time='${start_time}'"

echo -e "\n${bst}" >> /etc/profile

source /etc/profile


nohup sh bstart.sh >> /dev/null 2>&1 &

;;


########
"-stop")

shid=`ps -ef | grep bstart.sh | grep -v grep`


if [[ "$shid" == "" ]]; then
#参数2为空
echo "process not found"

exit 0
else

rm -f run.txt
rm -f *.m3u8
sh bend.sh
fi 
 ;;


#######
"-t")

if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then


shid=`ps -ef | grep bstart.sh | grep -v grep`

if [[ "$shid" != "" ]]; then
echo "process already had"
exit 0
fi

wget "http://api.live.bilibili.com/room/v1/Room/playUrl?cid=${cid}&qn=10000&platform=h5" -O web.json >> log.txt 2>&1
durl=`jq -r .data.durl[0].url web.json`
rm -rf web.json
results=`curl "${durl}" 2>&1|grep EXTM3U`

if [[ "$results" == "" ]]
then
echo -e "\033[31mm3u8Link can't found\033[0m"
exit 0
fi 


bch -target
start_time=`date +%m-%d-%H:%M`
echo -e "\033[32m${start_time}\ntime:${2}\033[0m"

sed -i '/bst_time/d' /etc/profile
source /etc/profile

bst="export bst_time='${start_time}'"

echo -e "\n${bst}" >> /etc/profile

source /etc/profile

declare -x catchTime="$2"  
nohup sh bstart.sh >> /dev/null 2>&1 &

else
echo "bch -t [time:s]"
exit 0
fi
 
;;
 
########定时执行
"-settime")
rm -f btask
sed -i '/btask/d' /var/spool/cron/root

service crond start >> log.txt 2>&1

date=`echo "$2" | grep [0-1][0-9]"-"[0-3][0-9]"-"[0-2][0-9]`

if [[ "$date" == "" ]]; then
echo "bch -settime [MM-DD-HH]"
exit 0
fi

MM=`echo ${date:0:2}`
DD=`echo ${date:3:2}`
HH=`echo ${date:6:2}`


#创建任务
echo -e "* ${HH} ${DD} ${MM} * root source /etc/profile;${bchPATH}/btask" >> /var/spool/cron/root

echo "#!/bin/bash" >> btask
echo "#${date}" >> btask
echo "bch -cid ${cid}" >> btask

echo "wget 'http://api.live.bilibili.com/room/v1/Room/playUrl?cid=${cid}&qn=10000&platform=h5' -O web.json >> log.txt 2>&1" >> btask

echo 'durl=`jq -r .data.durl[0].url web.json`;rm -rf web.json;results=`curl ${durl} 2>&1|grep EXTM3U`' >> btask

echo 'if [[ "$results" == "" ]];then' >> btask
echo 'exit 0;fi' >> btask


echo "bch -start" >> btask
echo "sed -i '/btask/d' /etc/crontab" >> btask
echo "rm -f ${bchPATH}/btask" >> btask
chmod 755 btask
echo "book task : ${date}"

;;


########
"-task")

if [ ! -e "btask" ]
then
echo "haven't any task"
exit 0
fi
task=`cat btask | grep "#"[0-9][0-9]`
echo -e "\033[32m${task}\033[0m"

;;



########
"-path")

echo "${bchPATH}"
 
;;


########
"-now")

shid=`ps -ef | grep bstart.sh | grep -v grep`

if [[ "$shid" == "" ]]; then
#参数2为空
echo "process not found"
exit 0

fi

echo -e "\033[32mhave process | ${bst_time}\033[0m"


;;


########
"-anu")

if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x uid="$2"
declare -x anmode="uid"
sh ana.sh

else
echo "bch -anu [uid]"
exit 0
fi


;;

########
"-anc")


if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x cid="$2"
declare -x anmode="cid"
sh ana.sh

else
echo "bch -anc [cid]"
exit 0
fi

;;

########
"-cid")
if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

results=`wget -q -O- "http://api.live.bilibili.com/room/v1/Room/room_init?id=$2" | grep "ok"`

#链接检测
if [[ "$results" == "" ]]
then
#url无效，结束程序
echo "invalid cid"
exit 0
fi


curl -G -s 'http://api.live.bilibili.com/room/v1/Room/room_init' \
--data-urlencode "id=$2"  > info
uid=`jq -r .data.uid info`
curl -G -s 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info
name=`jq -r  .data.name info`
title=`jq -r  .data.live_room.title info`
rm -f info

echo "$2" > target
echo -e "\033[32mname:${name} \ntitle:${title} \ntarget locked\033[0m"




else
echo "bch -cid [cid]"
exit 0
fi

;;

########
"-target")

curl -G -s 'http://api.live.bilibili.com/room/v1/Room/room_init' \
--data-urlencode "id=${cid}"  > info
uid=`jq -r .data.uid info`
curl -G -s 'http://api.bilibili.com/x/space/acc/info' \
--data-urlencode "mid=${uid}"  > info
name=`jq -r  .data.name info`
title=`jq -r  .data.live_room.title info`
rm -f info

echo -e "\033[32mtarget name:${name} \ntitle:${title}\033[0m"


;;


########
"-data")
jq  . user_data
;;

"-setting")
echo -e "\033[32mPATH:${bchPATH}/setting\033[0m"
cat setting
;;


"-set")
vi setting
;;

"-update")

function Progress(){
printf "update:[%-14s]%d%%\r" $b $progress
b=##$b
}
progress=0
Progress


test=`wget --spider https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/bch.sh > version1 2>&1`

test=`cat version1 | grep 404`

rm -f version1

progress=10
Progress

if [[ "$test" != "" ]];then

wget https://smallpipe.xyz/bch/bstart.sh -O bstart.sh > /dev/null 2>&1

progress=20
Progress

wget https://smallpipe.xyz/bch/bend.sh -O bend.sh > /dev/null 2>&1

progress=35
Progress

wget https://smallpipe.xyz/bch/catch.sh -O catch.sh > /dev/null 2>&1

progress=50
Progress

wget https://smallpipe.xyz/bch/ana.sh -O ana.sh > /dev/null 2>&1

progress=65
Progress

wget https://smallpipe.xyz/bch/install.sh -O install.sh > /dev/null 2>&1

progress=80
Progress

wget https://smallpipe.xyz/bch/bch.sh -O bch.sh > /dev/null 2>&1

else

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/bstart.sh -O bstart.sh > /dev/null 2>&1

progress=20
Progress

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/bend.sh -O bend.sh > /dev/null 2>&1

progress=35
Progress

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/catch.sh -O catch.sh > /dev/null 2>&1

progress=50
Progress

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/ana.sh -O ana.sh > /dev/null 2>&1

progress=65
Progress

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/install.sh -O install.sh > /dev/null 2>&1

progress=80
Progress

wget https://raw.githubusercontent.com/LingkongSky/Bilibili-source/main/bch.sh -O bch.sh > /dev/null 2>&1

fi
progress=100
Progress

sleep 0.5

echo

sh install.sh

exit 0
;;


########
"-help")
echo -e "Welcome to use the BiliBili-Source-Catch"
echo "use it by the command:"

echo -e "bch [-option]\n-start [需在bch -cid指定目标后使用]\n-stop [停止已有的抓取进程并保存]\n-t [time:S] [指定时间长度抓取，大小为S]\n-settime [MM-DD-HH] [通过输入月份-日期-小时来设置定时抓取任务]\n-task [查看是否有定时抓取任务存在]\n-path [查看当前的工作目录]\n-now [查看正在进行的抓取进程信息]\n-anu [uid] [通过用户uid收集信息并收录进user_data]\n-anc [cid] [通过用户cid收集信息并收录进user_data]\n-cid [cid] [指定抓取目标cid]\n-data [查看已抓取的信息]\n-setting [查看配置文件]\n-set [编辑配置文件]\n-update [升级BCH]\n-help [查看指令帮助]"


;;


*)
 
echo "input -help to get the use way or enter [ -v | -start | -stop | -t | -settime | -task | -path | -now | -anu | -anc | -cid | -target | -data | -setting | -set | -update | -help ]"
 
;;
 
esac

cd ../