#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [ `setxkbmap -query|grep layout|awk '{print $NF}'` != "us" ]; then
setxkbmap us
echo "English"|osd_cat --pos bottom --offset -90 --indent 45 --align right -c green --delay 1 -f '-*-*-*-*-*-*-24-*-*-*-*-*-*'
fi