#!/bin/bash
 
# case语句使用场景
 
case "$1" in
 
"-v")
 
echo "Bilibili-Catch Version 0.01 @Lingkongsky"
 


;;
 
"stop")
 
echo "服务关闭中..."
 
;;
 
"restart")
 
echo "服务重启中..."
 
;;
 
*)
 
echo "$0 脚本的使用方式： $0 [ start | stop | restart ]"
 
;;
 
esac

