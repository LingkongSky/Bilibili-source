curl -G 'http://api.live.bilibili.com/room/v1/Room/room_init' \
--data-urlencode "id=${cid}"  > info

jq -r .data.durl[1].url info > info.txt

rm -f info