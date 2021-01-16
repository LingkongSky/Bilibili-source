#!/bin/bash
 
# case语句使用场景
 
case "$1" in
 
"-v")
 
 
echo -e "\033[32mBilibili-Catch Version 0.1.0 @Lingkongsky\033[0m"

;;
 
"stop")
 
echo "服务关闭中..."
 
;;
 
"restart")
 
echo "服务重启中..."
 
;;
 
*)
 
echo "use it by [ -v ]"
 
;;
 
esac

