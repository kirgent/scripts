#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

if [ -z "$1" ]; then
echo "no input file specified!"
echo "how to use: cleanup.sh \$1=file"
exit
fi

### Removes all control-escape ^[...
### these escapes break output to window!
echo -n "Removes all control-escape ^[[x;xxx^[[xx;xx ..."
sed -i 's/.\[[0-9]\{1,3\};[0-9]\{1,3\}[0-9a-zA-Z]//g' $1 && echo " - done!"

### Removes all carriage return \r = ^M
echo -n "Removes all carriage return \r = (^M) ..."; sed -i 's/\r//g' $1 && echo " - done!"
echo -n "Removes all carriage return ^M ..."; sed -i 's/\^M//g' $1 && echo " - done!"

### Removes all backspace return \b = ^H
echo -n "Removes all carriage return \b = (^H)..."; sed -i 's/\b//g' $1 && echo " - done!"

### Removes all empty strings
echo -n "Removes all empty strings ^$ ..."; sed -i '/^$/d' $1 && echo " - done!"
echo -n "Removes all empty strings ^ *$ ..."; sed -i '/^ *$/d' $1 && echo " - done!"

### Removes all control-escape ^[ - doesn't work( don't know why(
#sed -i 's|\e\[.\{5\}||g' $1
