#!/bin/bash

if [ `setxkbmap -query|grep layout|awk '{print $NF}'` != "ru" ]; then
setxkbmap ru
echo "Russian"|osd_cat --pos bottom --offset 40 --align right -c green --delay 1 -f '-*-*-*-*-*-*-16-*-*-*-*-*-*'
fi
