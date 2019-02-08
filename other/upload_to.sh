#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

file="$1"
server="$2"
folder="$3"

if [ -z "$file" ]; then echo -e "No input file specified!\nHow to use: upload_to.sh \$1=file \$2=login@server [\$3=folder]"; exit
else
if [ ! -e "$file" ]; then echo "File is not exist!"; exit; fi
fi

if [ -z "$server" ]; then echo -e "No input server specified!\nHow to use: upload_to.sh \$1=file \$2=login@server [\$3=folder]"; exit; fi
if [ -z "$folder" ]; then folder="$HOME"; fi

echo -e "Uploading file=$file -> to server=$server -> to remote folder=$folder..."
ls -l $file
scp -C -p -P 22 "$file"* $server:"$folder"
result="$?"

if [ "$result" -eq "0" ]; then
echo "Source file will be removed after 30sec (or press ctrl+c)..."
sleep 30
rm -v "$file"
fi
