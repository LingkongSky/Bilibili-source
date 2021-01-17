#!/bin/bash

bashrcF=`cat /root/.bashrc`

bashrcS=`grep "bch" /root/.bashrc`

if [ -n "$bashrcS" ]; then
echo "bch already installed"
else

comm="alias bch='/root/lingkong/bch.sh'"

echo -e "\n${comm}" >> /root/.bashrc

source ~/.bashrc

cp /root/lingkong/bch.sh /bin/bch

chmod 777 /bin/bch

echo "install finished"

fi

cp /root/lingkong/bch.sh /bin/bch

chmod 777 /bin/bch

bch -v