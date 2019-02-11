#!/bin/sh

#if [ $(whoami) != "root" ];then 
#	echo -e "\n>>> you must be root to run\n"
#	exit 1
#fi

FOLDER="/home/kir_"
BACKUP="$FOLDER/backup.tar.gz"

sudo tar vcfz $BACKUP \
/etc \
/usr/share/X11/xkb/symbols/inet \
/usr/share/X11/xkb/rules/base \
/usr/share/X11/xkb/rules/base.xml \
/usr/share/X11/xkb/rules/base.lst \
/boot \
/usr/my \
/var/lib/portage/world \
$FOLDER/.bash* \
/root/.bashrc \
/root/.bash_profile \
$FOLDER/.bashrc \
$FOLDER/.bash_profile \
$FOLDER/.gkrellm2 \
$FOLDER/.htoprc \
$FOLDER/.mc \
$FOLDER/.mplayer \
$FOLDER/.xbindkeysrc \
$FOLDER/.kde4
#sudo mount /media/sd && sudo cp -fv $BACKUP /media/sd && sudo umount -v /media/sd
