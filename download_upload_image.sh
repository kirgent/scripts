#!/bin/bash
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

build="$1"
platform="worldbox"

#1.1:
#branch="CHARTER_WB_HUMAXWB1.1_17.3"
#branch="CHARTER_WB_HUMAXWB1.1_25.4"
#folder="humaxbw11"

#2.0:
branch="CHARTER_WB_HUMAXWB2.0_25.4"
#branch="CHARTER_WB_HUMAXWB2.0_17.3"
folder="humaxwb20"


username="kirill.grushin"
password="qwpoexplorer"

if [ ! -x "`which wget 2>/dev/null`" ]; then echo "No wget detected, please check!"; exit; fi

if [ -z "$build" ]; then echo -e "No build specified!\nSYNOPSYS\n\tdownload_upload_to.sh BUILD"; exit
fi

wget --ftp-user=$username --ftp-password=$password ftp://ftp.developonbox.ru/common/SCM/builds/charter/$platform/$branch/$build/dev/PCI_spectrum1*_210*_SLG.vmlinuz-initrd
result="$?"
echo "result=$result"

if [ "$result" -eq "0" ]; then
file="$branch.vmlinuz-initrd"
mv -v PCI_spectrum*_SLG.vmlinuz-initrd "$file"

upload_to.sh $file kirill.grushin@10.12.1.100 /tftpboot/$folder no

#upload_to.sh $file kirill.grushin@10.12.1.35 /tftpboot/worldbox2.0/smoke_humax_20_3 yes

fi
