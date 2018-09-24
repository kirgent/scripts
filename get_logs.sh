#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

ip="$1"
d=`date +%a`
log="/disk1/dvs/cmd2000/logs/cmd2000_log_"$d".txt"

if [ -z "$ip" ]; then echo -e "no input ip!\nhow to use: ./get_logs.sh <ip_box>,  e.g. ./get_logs.sh 10.243.40.71"; exit 1; fi

grep -w "$ip" "$log" > cmd2000_log_"$d"_"$ip".log
result="$?"
if [ "$result" -eq "0" ]; then
echo "logs are found:"
ls -l cmd2000_log_"$d"_"$ip".log
else
echo "No logs found for your IP at dncs 10.253.8.1:/disk1/dvs/cmd2000/logs/cmd2000_log_"$d".txt"
rm "cmd2000_log_"$d"_"$ip".log"
fi
