#!/bin/bash
source /etc/profile
cd ${bchPATH}
rm video/list.txt -f

source ${bchPATH}/setting
timenow=`date +%m-%d_%H-%M`
declare -x bend_id="$$"
#输出文件列表
mkdir ${results_path}

list_name=`ls video/*.ts`

if [[ ! "$list_name" =~ "ts" ]];then
put_path=$(cd `dirname $0`; pwd)
echo -e "\033[31mWithout found the target mp4 ts in $put_path/video\033[0m"
exit 0
fi
cd video/
ls  *.ts > list.txt




#添加前缀
prefix="file '"
perfix1="'"

awk '{print "'"$prefix"'"$0}' list.txt > list1.txt

awk '{print $0"'"$perfix1"'"}' list1.txt > list.txt

rm -f list1.txt

cd ../

ffmpeg -y -f concat -safe 0 -i video/list.txt -c copy "${results_path}"/"$timenow"."${Vtype}"


wait

if [[ ! -d "${bchPATH}/trash" ]]; then
mkdir trash
fi

mkdir ${bchPATH}/trash/$timenow

mv ${bchPATH}/video/* ${bchPATH}/trash/$timenow


echo -e "\033[32mResult already put into the ${results_path}/\033[0m"


rm -f run.txt
rm -f *.m3u8
rm -rf video
rm -f web.json

cd ../

unset bend_id

echo -e "\033[32mStart at ${bst_time}\033[0m"
unset bst_time
echo -e "\033[32mCatching Finished \033[0m"