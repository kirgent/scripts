#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

file="$1"
server="$2"
folder="$3"

if [[ -z "$file" ]]; then echo -e "No file specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER]"; exit
else
if [[ ! -e "$file" ]]; then echo "File is not exist!"; exit; fi
fi

if [[ -z "$server" ]]; then echo -e "No remote server specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [[ -z "$folder" ]]; then folder="."; fi

#####################

mv -v ${file} d/kirgent25.4.vmlinuz-initrd
file="d/kirgent25.4.vmlinuz-initrd"

#####################


echo -e "Uploading file=$file -> to server=$server -> to remote folder=$folder..."
ls -l ${file}
scp -p -P 22 "$file"* ${server}:"$folder"
result="$?"

if [[ "$result" -eq "0" ]]; then
echo "Source file will be removed after 10sec (or press ctrl+c)..."
sleep 10
rm -v "$file"
fi
