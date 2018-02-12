#!/bin/sh
# written by Kirill Grushin (kirill.grushin@dev.zodiac.tv)

#if [ $(whoami) != "root" ];then 
#	echo -e "\n>>> you must be root to run\n"
#	exit 1
#fi

BASEDIR="$HOME/scripts"
filename="backup_office.tar.gz"

rm -v "$BASEDIR/$filename"

tar vcfz $filename \
$BASEDIR \
/etc/X11/xorg.conf \
/etc/X11/xorg.conf.d \
/root/.bashrc \
/root/.bash_profile \
$HOME/.bash* \
$HOME/.bashrc \
$HOME/.bash_profile \
$HOME/.config/mc \
$HOME/.xbindkeysrc \
$HOME/.fluxbox/startup \
$HOME/.fluxbox/keys

mv -v $filename $BASEDIR
#sudo mount /media/sd && sudo cp -fv $BACKUP /media/sd && sudo umount -v /media/sd
