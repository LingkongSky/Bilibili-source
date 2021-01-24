#!/bin/bash


bashrcS=`grep "bch" /root/.bashrc`

#profileF=`cat /etc/profile`
profileS=`grep "bch" /etc/profile`

if [ -n "$bashrcS" ]; then
echo "bch already installed"
else

comm="alias bch='${bchPATH}/bch.sh'"

echo -e "\n${comm}" >> /root/.bashrc

source ~/.bashrc

echo "update finished"

fi

if [ ! -n "$profileS" ]; then

:<<EOF
cd /etc/
sed '/bch/d' profile  > profile1
rm -f profile
cp profile1 profile
cd ../
EOF

axx="export bchPATH='/root/lingkong'"

echo -e "\n${axx}" >> /etc/profile

source /etc/profile

echo "install finished"
fi

if [ ! -e user_data ]; then
echo -e "{\n\n}" > user_data
fi

cp ${bchPATH}/bch.sh /bin/bch
chmod 777 /bin/bch

bch -v
