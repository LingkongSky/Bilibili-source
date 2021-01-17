#!/bin/bash
 
# case语句使用场景
case "$1" in
 
##########
"-v")
 
echo -e "\033[32mBilibili-Catch Version 0.2.1 @Lingkongsky\033[0m"

;;
 
#######
"-t")
 
if [ ! -n "$2" ]; then
#参数2为空
echo "bch -t [time:s]"

exit 0
else

#参数2非空
declare -x catchTime="$2"  

#echo "$catchTime"

sh /root/lingkong/bstart.sh
fi 
 
;;
 
 
########
"-path")

echo "${bchPATH}"
 
;;

########
"-url")

"please input right URL"
 
;;


########
"restart")
 
echo "服务重启中..."
 
;;
 

########
"stop")

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
 
echo "use it by [ -v | -t | -path | url |stop ]"
 
;;
 
esac

