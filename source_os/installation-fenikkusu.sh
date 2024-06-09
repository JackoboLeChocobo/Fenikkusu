#!/bin/bash
#
# Installation
# Projet Fenikkusu
#

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

	apt install progress grub-pc-bin grub-efi-amd64-bin

	umount /media/install/mnt
	umount /media/install/datas
	umount /media/*/*

	mkdir -pv /media
	mdkir -pv /media/install
	mkdir -pv /media/install/mnt
	mkdir -pv /media/install/datas

	wipefs -af ${dev}

	(
	echo g
	echo n
	echo 1
	echo 
	echo +600M
	echo n
	echo 2
	echo 
	echo 
	echo t
	echo 1
	echo uefi
	echo M
	echo a
	echo r
	echo w
	) | sudo fdisk --wipe=always --wipe-partitions always $dev

	systemctl daemon-reload

	mkfs.fat -F32 ${dev}1
	mkfs.ext4 ${dev}2
		
	mount -o umask=000 ${dev}1 /media/install/mnt
	grub-install --removable --boot-directory=/media/install/mnt/boot --efi-directory=/media/install/mnt --target=x86_64-efi $dev

	uuid=`blkid -s UUID -o value ${dev}2`
	sleep 10
	
	echo "menuentry 'Fenikkusu'{" > /media/install/mnt/boot/grub/grub.cfg
	echo "insmod part_gpt" >> /media/install/mnt/boot/grub/grub.cfg
	echo "insmod ext2" >> /media/install/mnt/boot/grub/grub.cfg
	echo "search --no-floppy --fs-uuid --set=root $uuid" >> /media/install/mnt/boot/grub/grub.cfg
	echo "linux /Fenikkusu/boot/vmlinuz root=UUID=$uuid ro quiet splash perch" >> /media/install/mnt/boot/grub/grub.cfg
	echo "initrd /Fenikkusu/boot/initrfs.img" >> /media/install/mnt/boot/grub/grub.cfg
	echo "}" >> /media/install/mnt/boot/grub/grub.cfg
	

	mount ${dev}2 /media/install/datas
	echo "Copie des données en cours..."
	sleep 3
	cp -dR Fenikkusu /media/install/datas & progress -mp $!
	chmod 777 -R /media/install/datas
	
	umount /media/install/mnt
	umount /media/install/datas
	
	echo "Installation terminée !"
fi




