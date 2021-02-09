#!/bin/bash
function Progress(){
printf "install:[%-20s]%d%%\r" $b $progress
b=##$b
}
progress=0
Progress


test_jq=`ls /bin | grep jq`

progress=10
Progress

if [[ "${test_jq}" == ""  ]]; then
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 >> /dev/null
wait
chmod +x ./jq
cp jq /usr/bin
rm -rf jq
fi

progress=20
Progress

test_ffmpeg=`ls /bin | grep ffmpeg` 

if [[ "${test_ffmpeg}" == ""  ]]; then
echo "please make sure you are already install the ffmpeg"
exit 0
fi

progress=30
Progress

bashrcS=`grep "bch" /root/.bashrc`

#profileF=`cat /etc/profile`
profileS=`grep "bchPATH" /etc/profile`


progress=40
Progress

#添加项目工作路径
bpath=`pwd`
axx="export bchPATH='${bpath}'"
#单引号内为工作路径

progress=50
Progress
if [[ "$profileS" == "" ]]; then

echo -e "\n${axx}" >> /etc/profile
echo "install finished"

else

sed -i '/bchPATH/d' /etc/profile
echo -e "\n${axx}" >> /etc/profile
fi

source /etc/profile

progress=60
Progress

#添加自定义指令
comm="alias bch='${bchPATH}/bch.sh'"

progress=70
Progress

if [[ "$bashrcS" == "" ]]; then
echo -e "\n${comm}" >> /root/.bashrc
echo "update finished"

else

sed -i '/bch/d' /root/.bashrc
echo -e "\n${comm}" >> /root/.bashrc

fi

source ~/.bashrc


progress=80
Progress


#创建userdata
if [ ! -e user_data ]; then
echo -e "{\n\n}" > user_data
fi
progress=90
Progress
#将bch在bin中定义
rm -f /bin/bch
cp ${bchPATH}/bch.sh /bin/bch
chmod 755 /bin/bch
chmod 755 ${bchPATH}/bch.sh
progress=100
Progress
echo
bch -v