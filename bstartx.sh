#!/bin/bash

cd ${bchPATH}
source ${bchPATH}/setting

declare -x bstart_id="$$"


function ffover(){

kill -9 $ffpid >> /dev/null 2>&1

declare -x timenow2=`date +%m-%d_%H-%M`
declare -x bname2="$timenow2"."${Vtype}"

mv "${results_path}"/"$bname1" "${results_path}"/"$bname2"

exit 0
}


cid=`cat target`

curl -G -s 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json 
jq -r .data.durl[0].url web.json > durl.txt
declare -x dURL=`cat durl.txt`
rm -f durl.txt
rm -f web.json

touch run.txt
  
declare -x timenow1=`date +%m-%d_%H-%M`
declare -x bname1="$timenow1"."${Vtype}"

#start提示信息
echo -e "\033[32mstart \n$timenow1 \033[0m"


ffmpeg -i $dURL -vcodec copy -acodec copy "${results_path}"/"$bname1" >> log.txt 2>&1 &

ffpid=`ps -ef | grep ffmpeg | grep -v grep`



times="0"
if [ -n "$catchTime" ]; then 
MaxTimes="$catchTime"
else
MaxTimes="$MaxTime"
fi

#计时器
while [ "$times" -lt "$MaxTimes" ]
do

if [ ! -f "run.txt" ]
then
echo "Time over" >> log.txt 2>&1
ffover
fi


if [ -f "${results_path}"/"$bname1" ]
then
###抓取文件尺寸上限设定

size=`du -ms "${results_path}"/"$bname1"`
size=`echo $size  | sed 's/[ ][ ]*/\//g'`
size=`echo ${size%%/*}`

if [[ "$size" -gt "$MaxSize" ]]
then
echo "touch max size" >> log.txt 2>&1
echo "result saved"
rm -f run.txt
ffover
fi

ffpid1=`ps -ef | grep ffmpeg | grep -v grep`
if [[ "$ffpid1" == "" ]]
then
ffover
fi

fi

let times+=1
sleep 1

done


ffover
unset catchTime

cd ../


