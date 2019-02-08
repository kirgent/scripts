#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

file="$1"
server="$2"
folder="$3"

if [ -z "$file" ]; then echo -e "No input file specified!\nHow to use: download_from.sh \$1=file \$2=login@server [\$3=folder]"; exit; fi
if [ -z "$server" ]; then echo -e "No input server specified!\nHow to use: download_from.sh \$1=file \$2=login@server [\$3=folder]"; exit; fi
if [ -z "$folder" ]; then folder="$HOME"; fi

echo -e "Downloading file=$file\nfrom server=$server\nto local folder=$folder..."
scp -C -p -P 22 $server:"$file" "$folder"
result="$?"

if [ "$result" -eq "0" ]; then
echo "Source file will be removed after 30sec (or press ctrl+c)..."
sleep 30
ssh $server "rm $file"
fi
