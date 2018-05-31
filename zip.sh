#!/bin/bash

file="$1"

if [ ! -e "$file" ]; then echo "no file exist, exit."; exit; fi

zip "$file".zip "$file"
