#!/bin/bash

bmode="true"
dURL='www.nijigaku.club'
#extTIME=6

results=`wget --spider "$dURL"  2>&1|grep 200`

result=$(echo "$results" | grep "200")
bmode="true"

echo "3"

declare -x bchPATH=`cd \`dirname $0\`; pwd`

echo "$bchPATH"

sh ${bchPATH}/test.sh

