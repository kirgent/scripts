#!/bin/bash

file="$1"
target_folder="$HOME"
file_pattern="$HOME/scripts/patterns.txt"

ps fo user,pid,command|grep --color=always -E "script server.*log|tail_logs|tail -f.*log"

ls -lt "$target_folder/"|grep "server_"|awk '{print $NF}'
echo "================== ================== ================== ================== ================== ================== =================="

if [ -z "$file" ]; then
log=`ls -lt "$target_folder/"|grep "server_"|head -1|awk '{print $NF}'`
else
log=`ls -lt "$target_folder/"|grep "server_"|grep "$file"|head -1|awk '{print $NF}'`
fi

echo "use file_pattern : `wc -l $file_pattern`"
echo "use log          : $log"
echo "================== ================== ================== ================== ================== ================== =================="
if [ -n "$log" ]; then
tail -f "$target_folder/$log"|grep --color=always -Eaif "$file_pattern"
fi
