#!/bin/bash
mixer="Master"
sudo amixer -q set $mixer 3dB-
VOLUME=`sudo amixer sget $mixer | grep Mono: | sed -e "s/[^[]*\[\([^%]*\).*/\1/"`

# setup COLOR according with volume level
VOL=`sudo amixer sget $mixer | grep Mono: | cut -f6 -d\ `
if [ "$VOL" == "[0%]" ]; then COLOR="red"; else COLOR="green"; fi

osd_cat --pos bottom --offset 0 --align left --indent 0 --barmode percentage --percentage=$VOLUME --color=$COLOR --delay 1 --shadow 1 &
