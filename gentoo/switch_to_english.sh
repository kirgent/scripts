#!/bin/bash

if [ `setxkbmap -query|grep layout|awk '{print $NF}'` != "us" ]; then
setxkbmap us
echo "English"|osd_cat --pos bottom --offset 40 --align right -c green --delay 1 -f '-*-*-*-*-*-*-16-*-*-*-*-*-*'
fi
