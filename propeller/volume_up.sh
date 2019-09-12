#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

mixer="Master"

#sudo amixer -q set $mixer 3dB+
pactl set-sink-volume @DEFAULT_SINK@ +1000

VOLUME=`amixer sget $mixer | grep Mono: | sed -e "s/[^[]*\[\([^%]*\).*/\1/"`

# setup COLOR according with volume level
VOL=`amixer sget $mixer | grep Mono: | cut -f6 -d\ `
if [[ "$VOL" == "[100%]" ]]; then COLOR="red"; else COLOR="green"; fi

osd_cat --pos bottom --offset 0 --align left --indent 0 --barmode percentage --percentage=$VOLUME --color=$COLOR --delay 1 --shadow 1 &
