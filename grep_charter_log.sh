#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

file="$1"

if [ -z "$file" ]; then file="charter.log"; fi

if [ ! -e "$file" ]; then echo "no file exist, exit."; exit; fi

grep -niE --color=always -f ~/scripts/p.txt $file
