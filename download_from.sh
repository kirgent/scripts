#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

file="$1"
server="$2"
folder="$3"

if [ ! -x "`which scp 2>/dev/null`" ]; then echo "No scp detected, please check!"; exit; fi

cat scripts/server_10.12.1.99.sh|grep ssh
cat scripts/server_ctec1_10.12.1.100.sh|grep ssh
cat scripts/server_ctec_vm_10.12.1.35.sh|grep ssh

cat scripts/server_ams_172.30.112.19.sh |grep ssh
cat scripts/server_ams_172.30.82.132.sh |grep ssh
cat scripts/server_ams_172.30.81.4.sh |grep ssh

if [ -z "$file" ]; then echo -e "No file specified!\nSYNOPSYS\n\tdownload_from.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$server" ]; then echo -e "No remote server specified!\nSYNOPSYS\n\tdownload_from.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$folder" ]; then folder="$HOME"; fi

echo -e "Downloading file=$file  <--  from $server  -->  to local folder=$folder"
scp -C -p -P 22 $server:"$file" "$folder"
result="$?"
echo "result $result"

#if [ "$result" -eq "0" ]; then
#echo "Source file will be removed after 10sec (or press ctrl+c)..."
#sleep 30
#ssh $server "rm $file"
#fi
