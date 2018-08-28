#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

file="$1"
file_pattern="$HOME/scripts/patterns.txt"

if [ -z "$file" ]; then
echo -e "no input file specified!\nhow to use: grep.sh \$1=file"; exit
else
if [ ! -e "$file" ]; then echo "file not exist!"; exit; fi
fi

grep --color=always -Eainf "$file_pattern" "$file"
echo
ls -lh "$file"
read -p "Remove ?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
rm "$file"
fi
