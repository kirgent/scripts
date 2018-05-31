#!/bin/bash

build="$1"
platform="worldbox"
file="nfs_image-dev.zip"

#1.1:
#branch="CHARTER_WB_HUMAXWB1.1_17.3"
#branch="CHARTER_WB_HUMAXWB1.1_25.4"

#2.0:
#branch="CHARTER_WB_HUMAXWB2.0_25.4"
branch="CHARTER_WB_HUMAXWB2.0_17.3"


username="kirill.grushin"
password="qwpoexplorer"

if [ ! -x "`which wget 2>/dev/null`" ]; then echo "No wget detected, please check!"; exit; fi

if [ -z "$build" ]; then echo -e "No build specified!\nSYNOPSYS\n\tdownload_upload_to.sh BUILD"; exit; fi

wget --ftp-user=$username --ftp-password=$password ftp://ftp.developonbox.ru/common/SCM/builds/charter/$platform/$branch/$build/$file
result="$?"
echo "result=$result"

if [ "$result" -eq "0" ]; then
upload_to.sh $file kirill.grushin@10.12.1.35 /home/nfs_builds/humax_254/ yes
fi
