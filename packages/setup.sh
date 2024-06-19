#!/bin/bash

# Packages
# Projet Fenikkusu

packfenikkusu=`zenity \
	--width=600 --height=300 \
	--title="Fenikkusu - Installation" \
	--text="Choisissez la catégorie désirée. périphérique USB désirée" \
	--list \
	--column="Catégorié" \
	--column="Description" \
	"/apps-bureautique" "Logiciels pour une utilisation quotidienne" \
	"/apps-jeux" "Logiciels pour pouvoir jouer avec vos jeux" \
	"/apps-nvidia" "Installation des drivers pour votre carte Nvidia" \
	"/apps-programmation" "Logiciels pour développer vos projets informatiques" \
	"/apps-reseau" "Logiciels concernant le réseau informatique" 2> /dev/null`

if echo "$packfenikkusu" | grep '/'; then
	chmod +x /etc/fenikkusu/Fenikkusu/packages/${packfenikkusu}.sh
	/usr/bin/lxterminal -e "sudo /etc/fenikkusu/Fenikkusu/packages/${packfenikkusu}.sh"
fi
