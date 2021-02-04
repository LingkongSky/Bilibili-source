#!/bin/bash

test_jq=`ls /bin | grep jq`
if [[ "${test_jq}" == ""  ]]; then
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
cp jq /usr/bin
fi

test_ffmpeg=`ls /bin | grep ffmpeg` 

if [[ "${test_ffmpeg}" == ""  ]]; then
echo "please make sure you are already install the ffmpeg"
exit 0
fi


bashrcS=`grep "bch" /root/.bashrc`

#profileF=`cat /etc/profile`
profileS=`grep "bchPATH" /etc/profile`



#添加项目工作路径
bpath=`pwd`
axx="export bchPATH='${bpath}'"
#单引号内为工作路径

if [ ! -n "$profileS" ]; then

echo -e "\n${axx}" >> /etc/profile
echo "install finished"

else

sed -i '/bchPATH/d' /etc/profile
echo -e "\n${axx}" >> /etc/profile
fi

source /etc/profile


#添加自定义指令
comm="alias bch='${bchPATH}/bch.sh'"

if [ ! -n "$bashrcS" ]; then
echo -e "\n${comm}" >> /root/.bashrc
echo "update finished"

else

sed -i '/bchPATH/d' /root/.bashrc
echo -e "\n${comm}" >> /root/.bashrc

fi

source ~/.bashrc

#创建userdata
if [ ! -e user_data ]; then
echo -e "{\n\n}" > user_data
fi

#将bch在bin中定义
cp ${bchPATH}/bch.sh /bin/bch
chmod 755 /bin/bch
chmod 755 ${bchPATH}/bch.sh
bch -v