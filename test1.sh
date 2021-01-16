#!/bin/bash

bmode="true"
dURL='www.nijigaku.club'
#extTIME=6

results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")
bmode="true"

if [ ! -f /video/*.ts ];then
put_path=$(cd `dirname $0`; pwd)
echo -e "\033[31mWithout found the target ts in $put_path/video\033[0m"
exit 0
fi

echo "over"
#kill $$ &