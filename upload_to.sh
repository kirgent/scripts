#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

file="$1"
server="$2"
folder="$3"
remove="$4"

if [ ! -x "`which scp 2>/dev/null`" ]; then echo "No scp detected, please check!"; exit; fi

cat ~/scripts/server_10.12.1.99.sh|grep ssh
cat ~/scripts/server_ctec1_10.12.1.100.sh|grep ssh
cat ~/scripts/server_ctec_vm_10.12.1.35.sh|grep ssh

cat ~/scripts/server_ams_172.30.112.19.sh |grep ssh
cat ~/scripts/server_ams_172.30.82.132.sh |grep ssh
cat ~/scripts/server_ams_172.30.81.4.sh |grep ssh

if [ -z "$file" ]; then echo -e "No file specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER] [REMOVE]"; exit
else
if [ ! -e "$file" ]; then echo "File is not exist!"; exit; fi
fi

if [ -z "$server" ]; then echo -e "No remote server specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$folder" ]; then folder="."; fi

if [ -z "$remove" ]; then remove="yes"; fi

echo -e "Uploading file=$file  -->  to $server  -->  to remote folder=$folder"
ls -l "$file"
scp -C -p -P 22 "$file"* $server:"$folder"
result="$?"
echo "result $result"

if [ "$result" -eq "0" ]; then
if [ "$remove" == "yes" ]; then
echo "Source file will be removed after 30sec (or press ctrl+c)..."
sleep 30
rm -v "$file"
fi
fi
