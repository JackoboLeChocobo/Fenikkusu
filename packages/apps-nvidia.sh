#!/bin/bash

# Applications : NVIDIA
# Projet Fenikkusu
# Applications nécessaires :
# - Driver Nvidia
# - NVIDIA Settings

sed -i -r 's/bookworm main non-free-firmware/bookworm main non-free-firmware contrib non-free/g' /etc/apt/sources.list
apt update
apt install nvidia-driver firmware-misc-nonfree

cp apps-nvidia-icones/* /etc/fenikkusu/openbox-icons/

echo " "
echo "###################################"
echo "# APPS INSTALLEES"
echo "###################################"
echo " "
echo "Driver NVIDIA ( Redémarrage du PC nécessaire )"
echo " "
echo "Vous pouvez ajouter ces informations pour configurer votre menu désormais."
echo "- Menu > Configurer Le Menu"
echo "Puis dans l'application, ouvrir le fichier '.config/openbox/debian-menu.xml' de votre dossier Utilisateur."
echo " "
echo "NVIDIA Settings :"
echo "- Catégorie suggérée : Système"
echo "- Nom suggéré : Configuration NVIDIA"
echo "- Executable : /usr/bin/nvidia-settings"
echo "- Icone : /etc/fenikkusu/openbox-icons/nvidia-settings.svg"
