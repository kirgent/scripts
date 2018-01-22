#!/bin/bash

file="$1"
server="$2"
folder="$3"

if [ -z "$file" ]; then echo -e "No file specified!\nSYNOPSYS\n\tdownload_from.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$server" ]; then echo -e "No remote server specified!\nSYNOPSYS\n\tdownload_from.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$folder" ]; then folder="$HOME"; fi

echo -e "Downloading file=$file\nfrom server=$server\nto local folder=$folder..."
scp -C -p -P 22 $server:"$file" "$folder"
result="$?"

if [ "$result" -eq "0" ]; then
echo "Source file will be removed after 10sec (or press ctrl+c)..."
sleep 10
ssh $server "rm $file"
fi
