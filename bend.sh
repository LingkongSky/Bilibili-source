cd /root/lingkong/
rm video/list.txt -f

prefix="file '"
perfix1="'"
timenow=`date +%m%d%H%M`
#输出文件列表

cd /root/lingkong/video/
ls  *.mp4 > list.txt
cd ../

#删除最后一行
sed -i '$d' video/list.txt

#添加前缀
cd /root/lingkong/video/

awk '{print "'"$prefix"'"$0 > "list.txt"}' list.txt

awk '{print $0"'"$perfix1"'"}' list.txt

cd ../



ffmpeg -f concat -i video/list.txt -c copy results/"$timenow".mp4

rm video/*.mp4 -f
rm video/list.txt -f

cd ../