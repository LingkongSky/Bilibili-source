cd ${bchPATH}
rm video/list.txt -f

prefix="file '"
perfix1="'"
timenow=`date +%m%d%H%M`
declare -x bend_id="$$"
#输出文件列表


list_name=`ls video/*.mp4`

if [[ ! "$list_name" =~ "mp4" ]];then
put_path=$(cd `dirname $0`; pwd)
echo -e "\033[31mWithout found the target mp4 ts in $put_path/video\033[0m"
exit 0
fi

cd video/
ls  *.mp4 > list.txt

#删除最后一行
sed -i '$d' list.txt

#添加前缀
awk '{print "'"$prefix"'"$0 > "list.txt"}' list.txt

awk '{print $0"'"$perfix1"'"}' list.txt

cd ../


ffmpeg -f concat -safe 0 -i video/list.txt -c copy results/"$timenow".mp4

wait


put_path=$(cd `dirname $0`; pwd)

echo -e "\033[32mResult already put into the $put_path/results/\033[0m"


rm -f run.txt
rm -f *.m3u8
rm -rf video
rm -f web.json
mv video/*.* /root/trash
cd ../

unset bend_id
echo -e "\033[32mCatching Finished \033[0m"