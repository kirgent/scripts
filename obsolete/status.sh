#!/bin/bash

if [ -f "$HOME/config.cfg" ]; then source $HOME/config.cfg; elif [ -f "$HOME/cygwin/config.cfg" ]; then source $HOME/cygwin/config.cfg; fi

#only for dvbs:
#cmd=/home/kirill.grushin/cmd2000

echo "telnet sessions:"
ps aux|grep --color=always -E "telnet 10.11.[0-9].[0-9][0-9][0-9]$"|awk '{print $1, $11, $NF}'
#ps aux|grep --color=always -E "telnet 192.168.23.[0-9][0-9]$"|awk '{print $1, $11, $NF}'
echo


echo "started logs:"
ps aux|grep script|grep --color=always _server_|awk '{print $NF}'
echo


echo "ALL log files:"
#ls -lh *_server_`TZ='America/New_York' date "+%d%m%Y"`*.log
ls -lh *_server_*.log
echo


echo "running tests:" 
ps aux|grep --color=always -E "test_.*10.11.[0-9].[0-9][0-9][0-9]$"|awk '{print $12, $NF}'
#ps aux|grep --color=always -E "test_.*192.168.23.[0-9][0-9]$"|awk '{print $12, $NF}'
echo


echo "versions (Is supervisor alive or died?):"
# sun:
#for ip in $(ps aux|grep -E "telnet 192.168.23.[0-9][0-9]$"|awk '{print $NF}')
# FSP/ZODIAC:
for ip in $(ps aux|grep -E "telnet 10.11.[0-9].[0-9][0-9][0-9]$"|grep kirill|awk '{print $NF}')
# DVBS:
#for ip in $(ps aux|grep -E "telnet 10.11.[0-9].[0-9][0-9][0-9]$"|grep `set|grep EUID=|cut -c6-`|awk '{print $NF}')
do
#$cmd $ip "dal status" 2>/dev/null|grep --color=always -E ": Version:|SUPERVISOR_VERSION|DVBS_FIRMWARE_VERSION|GroupUrl"
#$cmd $ip "dal status" 2>/dev/null|grep --color=always -E ": Version:"
#$cmd $ip "dal status" 2>/dev/null|grep --color=always -E "DVBS_FIRMWARE_VERSION"
$cmd $ip "dal status" 2>/dev/null|grep --color=always -E "SUPERVISOR_VERSION"
#$cmd $ip "dal status" 2>/dev/null|grep --color=always -E "GroupUrl"
done
echo


read -p "grep3.sh ?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
./grep3.sh
fi

#screen -ls|egrep kir[0-9] --color=never|awk '{print $1}' > screennames.txt
