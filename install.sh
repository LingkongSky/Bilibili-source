#!/bin/bash

test_jq=`ls /bin | grep jq`
if [[ "${test_jq}" == ""  ]]; then
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
cp jq /usr/bin
fi

ls /bin | grep ffmpeg

if [[ "${test_jq}" == ""  ]]; then
echo "please make sure you are already install the ffmpeg"
exit 0
fi


bashrcS=`grep "bch" /root/.bashrc`

#profileF=`cat /etc/profile`
profileS=`grep "bch" /etc/profile`

#添加自定义指令
if [ -n "$bashrcS" ]; then
echo "bch already installed"
else
comm="alias bch='${bchPATH}/bch.sh'"
echo -e "\n${comm}" >> /root/.bashrc
source ~/.bashrc
echo "update finished"
fi

#添加项目工作路径
if [ ! -n "$profileS" ]; then
axx="export bchPATH='/root/lingkong'"
#单引号内为工作路径

echo -e "\n${axx}" >> /etc/profile
source /etc/profile

echo "install finished"
fi


#创建userdata
if [ ! -e user_data ]; then
echo -e "{\n\n}" > user_data
fi


#在crontab中调用环境变量
sour=`cat /etc/crontab | grep source`
if [[ "$sour" == "" ]]; then
echo -e "\nsource /etc/profile" >> /etc/crontab
fi

#将bch在bin中定义
cp ${bchPATH}/bch.sh /bin/bch
chmod 755 /bin/bch
chmod 755 ${bchPATH}/bch.sh
bch -v