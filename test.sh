#!/bin/bash

timenow= `date +%m%d%H%M`
echo "$timenow"

awk 'NR==5 {print $k}' /root/lingkong/live_example.m3u8