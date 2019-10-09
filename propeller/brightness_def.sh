#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

dev=/sys/class/backlight/intel_backlight/brightness

sudo chmod o+w $dev
echo '60000' > $dev

echo "$dev"
cat $dev