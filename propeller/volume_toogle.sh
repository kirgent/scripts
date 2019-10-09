#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

amixer sset Speaker unmute
amixer sset Headphone unmute
amixer sset Headphone 100%

amixer sset PCM 100%
amixer sset Speaker 100%

pactl set-sink-mute @DEFAULT_SINK@ toggle && echo "toogle muting"|osd_cat --pos bottom --offset -90 --indent 45 --align right -c green --delay 1 -f '-*-*-*-*-*-*-24-*-*-*-*-*-*' &