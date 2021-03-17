#!/bin/bash
source /etc/profile
cd ${bchPATH}/
rm list.txt -f

source ${bchPATH}/setting
timenow2=`date +%m-%d_%H-%M`
declare -x bend_id="$$"
#输出文件列表

if [[ ! -d "${results_path}" ]]; then
mkdir ${results_path}
fi



:<< EOF
cd video/

ls  *.ts > list.txt

#添加前缀
prefix="file '"
perfix1="'"

awk '{print "'"$prefix"'"$0}' list.txt > list1.txt

awk '{print $0"'"$perfix1"'"}' list1.txt > list.txt

rm -f list1.txt


cd ../

EOF

#ffmpeg -y -f concat -safe 0 -i video/list.txt -c copy "${results_path}"/"$timenow"."${Vtype}"

mv "${results_path}"/"$bname1" "${results_path}"/"$timenow2"."${Vtype}"

wait

if [[ ! -d "${bchPATH}/trash" ]]; then
mkdir trash
fi

mkdir ${bchPATH}/trash/"$timenow2"

mv ${bchPATH}/video/* ${bchPATH}/trash/"$timenow2"


echo -e "\033[32mResult already put into the ${results_path}/\033[0m"


rm -f run.txt
rm -f *.m3u8
rm -rf video
rm -f web.json
rm -rf video
rm -rf ts
rm -f download.txt
cd ../

unset bend_id

echo -e "\033[32mStart at ${bst_time}\033[0m"
unset bst_time
echo -e "\033[32mCatching Finished \033[0m"