cid='10112'
mainURL='https://cn-jxnc-cmcc-live-01.bilivideo.com/live-bvc/'
cd ${bchPATH}

curl -G 'http://api.live.bilibili.com/room/v1/Room/playUrl' \
--data-urlencode "cid=${cid}" \
--data-urlencode 'qn=10000' \
--data-urlencode 'platform=h5' > web.json

jq -r .data.durl[1].url web.json > durl.txt

durl=`cat durl.txt`  >> log.txt

durl=`echo ${durl%%.m3u8*}` >> log.txt

durl=`echo ${durl##*bvc}` >> log.txt
durl="$mainURL"+"$durl"
echo "$durl"