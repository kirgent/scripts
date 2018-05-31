#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

ip="$1"
d=`date +%a`
server="dryngach@10.253.8.1"
#pass=Z0di@c06

if [ -z "$ip" ]; then echo -e "no input ip specified!\nhow to use: ./get_logs_from_dncs.sh <ip_box>,  e.g. ./get_logs_from_dncs.sh 10.243.40.71"; exit 1; fi

sshpass -pZ0di@c06 ssh $server "./get_logs.sh $ip"
scp -C -p -P 22 $server:"cmd2000_log_"$d"_"$ip".log" .
result="$?"
if [ "$result" -ne "0" ]; then
echo "No logs found for your IP at dncs 10.253.8.1:/disk1/dvs/cmd2000/logs/cmd2000_log_"$d".txt"
fi
