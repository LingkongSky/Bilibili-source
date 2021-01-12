#!/bin/bash


:<<EOF
while true
   do
      sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 
      sleep 3
   done
EOF

timeout $1 sh bstart.sh


#sh /root/lingkong/catch.sh > /root/lingkong/log.txt 2>&1 