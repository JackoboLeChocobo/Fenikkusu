#!/bin/bash
#
# Installation
# Projet Fenikkusu
#

rm ./installation_liste_devs
for device in /sys/block/*
do
    if udevadm info --query=property --path=$device | grep -q ^ID_BUS=usb
    then
        dev=`udevadm info --query=property --path=$device | grep "^DEVNAME=" | sed "s/.*=//"`
        name=`udevadm info --query=property --path=$device | grep "^ID_MODEL=" | sed "s/.*=//"`
        donnees_liste=`echo $donnees_liste "$dev" "$name"`
    fi
done

dev=`zenity \
	--width=426 --height=240 \
	--title="Fenikkusu - Installation" \
	--text="Choisissez le périphérique USB désirée" \
	--list \
	--column="Périphérique" \
	--column="Nom" \
	$donnees_liste 2> /dev/null`

if echo "$dev" | grep '/'; then

	echo " "
	echo "Périphérique choisie : $dev"
	echo " "
	sleep 3

	#apt install grub-pc-bin grub-efi-amd64-bin

	mkfs.fat -F32 ${dev}1
	mkdir -pv /media/fenikkusu/setup/
	mkdir -pv /media/fenikkusu/setup/mnt
	mkdir -pv /media/fenikkusu/setup/data
	
	mount -o umask=000 /dev/sdX1 /media/fenikkusu/setup/mnt
	grub-install --removable --boot-directory=/media/fenikkusu/setup/mnt/boot --efi-directory=/media/fenikkusu/setup/mnt --target=x86_64-efi $dev
	touch /media/fenikkusu/setup/mnt/boot/grub/grub.cfg
	
	umount /media/fenikkusu/setup/mnt
fi




