#!/bin/bash
 
# case语句使用场景
case "$1" in
 
##########
"-v")
 
echo -e "\033[32mBilibili-Catch Version 0.2.95 @Lingkongsky\033[0m"

;;
 
#######
"-t")
 
if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x catchTime="$2"  
sh ${bchPATH}/bstart.sh &

else
echo "bch -t [time:s]"
exit 0
fi
 
;;
 
 
########
"-path")

echo "${bchPATH}"
 
;;

########
"-url")

if [ ! -n "$2" ]; then
#参数2为空
echo "bch -url [url]"
exit 0
fi 
 
results=`wget --spider "$2"  2>&1|grep 200`

result=$(echo "$results" | grep "200")

#链接检测
if [[ "$result" == "" ]]
then
#url无效，结束程序
echo -e "can not link to the URL. \nPlease check your URL"
exit 0

fi


if [ "$3" == "-t" ] && [ -z "$(echo $4 | sed 's#[0-9]##g')" ] && [ "$4" != "" ]; then

declare -x catchTime="$4"   
sh ${bchPATH}/bstart.sh

elif [[ "$3" == "-t" ]]; then
echo "bch -t [time:s]"
exit 0
fi

declare -x catchTime="20"   
sh ${bchPATH}/bstart.sh

;;

########
"-anu")

if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x uid="$2"
declare -x anmode="uid"
sh ${bchPATH}/ana.sh

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
sh ${bchPATH}/ana.sh

else
echo "bch -anc [cid]"
exit 0
fi

;;


########
"-data")

sh ${bchPATH}/data.sh

;;


########
"-help")
echo -e "Welcome to use the BiliBili-Source-Catch "
echo "make sure you have installed the bch and use it by the command:"

echo "[ -v | -t | -path | -url | -stop | -anu | -data | -anc | -help ]"


;;


########
"-bg")

echo -e "start the BiliBili-Source-Catch "
nohup sh bstart.sh>>log.txt 2>&1 &

;;
########
"-stop")

shid=`ps -ef | grep ${bchPATH}/bstart.sh`


if [ ! -n "$shid" ]; then
#参数2为空
echo "process not found"

exit 0
else

rm -f ${bchPATH}/run.txt
rm -f ${bchPATH}*.m3u8
#kill -9 "$shid"
sh ${bchPATH}/bend.sh
echo -e "\033[32malready killed\033[0m"
exit 0
fi 
 ;;

*)
 
echo "use it by [ -v | -t | -path | -url | -stop | -anu | -data | -anc | -help | bg]"
 
;;
 
esac

