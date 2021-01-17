#!/bin/bash
 
# case语句使用场景
 
case "$1" in
 
"-v")
 
echo -e "\033[32mBilibili-Catch Version 0.1.0 @Lingkongsky\033[0m"

;;
 
"-t")
 
if [ ! -n "$2" ]; then
#参数2为空
echo "bch -t [time:s]"

exit 0
else

#参数2非空
declare -x catchTime="$2"  

echo "$catchTime"

sh /root/lingkong/test1.sh

fi 
 
;;
 
"restart")
 
echo "服务重启中..."
 
;;
 
*)
 
echo "use it by [ -v ]"
 
;;
 
esac

