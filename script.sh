#!/bin/bash

postfix="$1"
date="`date +%d%m%y_%H%M%S`"
server="$2"

if [ -z "$postfix" ]; then
echo "no postfix specified!"
echo "how to use: ./script.sh \$1=postfix [\$2=server]"
grep ssh scripts/server_ctec1_10.12.1.100.sh
grep ssh scripts/server_10.12.1.99.sh
exit
fi

if [ -z "$server" ]; then server="server_10.12.1.99"; fi

script "$server"_"$date"_"$postfix.log"

read -p "Remove ?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
rm -v "`ls |grep *$date*|awk '{print $NF}'`"
fi

