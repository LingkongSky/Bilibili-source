#!/bin/bash
 
# case语句使用场景
case "$1" in
 
##########
"-v")
 
echo -e "\033[32mBilibili-Catch Version 0.2.6 @Lingkongsky\033[0m"

;;
 
#######
"-t")
 
if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x catchTime="$2"  
sh ${bchPATH}/bstart.sh

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
sh ${bchPATH}/anu.sh

else
echo "bch -anu [uid]"
exit 0
fi


;;


########
"-anc")


if [ -z "$(echo $2 | sed 's#[0-9]##g')" ] && [ "$2" != "" ]; then

declare -x cid="$2"
sh ${bchPATH}/anc.sh

else
echo "bch -anc [cid]"
exit 0
fi

;;


########
"restart")
 
echo "服务重启中..."
 
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
kill "$shid"

echo -e "\033[32malready killed\033[0m"
exit 0
fi 
 ;;



*)
 
echo "use it by [ -v | -t | -path | -url | -stop | -anu | anc ]"
 
;;
 
esac

