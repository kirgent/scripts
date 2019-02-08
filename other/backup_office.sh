#!/bin/bash
# written by Kirill Grushin (kirgent@gmail.com)

#if [ $(whoami) != "root" ];then 
#	echo -e "\n>>> you must be root to run\n"
#	exit 1
#fi

filename="backup.tar.gz"

tar vcfz $filename \
/root/.bashrc \
/root/.bash_profile \
$HOME/.bashrc \
$HOME/.bash_profile \
$HOME/.xbindkeysrc \
$HOME/.fluxbox/startup \
$HOME/.fluxbox/keys
