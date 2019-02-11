#!/bin/sh
clear
echo $0
echo used: ~/patterns.txt
echo used: /cygdrive/c/Users/User/Desktop/cooldob.log
tail -f /cygdrive/c/Users/User/Desktop/cooldob.log|grep --color=always -E -f ~/patterns.txt
