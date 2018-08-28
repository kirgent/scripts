#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [ `setxkbmap -query|grep layout|awk '{print $NF}'` == "us" ]; then
setxkbmap ru
echo "Russian"|osd_cat --pos bottom --offset 40 --align right -c green --delay 1 -f '-*-*-*-*-*-*-16-*-*-*-*-*-*'
else
setxkbmap us
echo "English"|osd_cat --pos bottom --offset 40 --align right -c green --delay 1 -f '-*-*-*-*-*-*-16-*-*-*-*-*-*'
fi
