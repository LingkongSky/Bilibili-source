#!/bin/bash

for ((i=0;$i<=20;i++))
do
let jinshu=$i*5
printf "[%-20s]%d%%\r" $b $jinshu
sleep 0.1
b=#$b
done
echo