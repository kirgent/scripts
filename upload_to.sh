#!/bin/bash

file="$1"
server="$2"
folder="$3"

if [ -z "$file" ]; then echo -e "No file specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER]"; exit
else
if [ ! -e "$file" ]; then echo "File is not exist!"; exit; fi
fi

if [ -z "$server" ]; then echo -e "No remote server specified!\nSYNOPSYS\n\tupload_to.sh FILE LOGIN@SERVER [FOLDER]"; exit; fi
if [ -z "$folder" ]; then folder="$HOME"; fi

echo -e "Uploading file=$file -> to server=$server -> to remote folder=$folder..."
ls -l $file
scp -C -p -P 22 "$file"* $server:"$folder"
result="$?"

if [ "$result" -eq "0" ]; then
echo "Source file will be removed after 10sec (or press ctrl+c)..."
sleep 10
rm -v "$file"
fi
