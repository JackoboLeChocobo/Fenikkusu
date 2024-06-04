#!/bin/bash

# Applications : Bureautique
# Projet Fenikkusu
#
# Applications nécessaires :
# - GIMP
# - Inkscape
# - Libre Office
# - Mozilla Firefox
# - VLC Media Player
#
# Applications optionnelles :
# - Upscayl
#
# Variables modifiables ( 1=Oui, 0=Non )
INSTALLER_UPSCAYL=1



# GIMP
apt install gimp

# INKSCAPE
apt install inkscape

# LIBRE OFFICE
wget https://appimages.libreitalia.org/LibreOffice-still.standard-x86_64.AppImage -P /etc/fenikkusu/openbox-scripts -c
chmod +x /etc/fenikkusu/openbox-scripts/LibreOffice-still.standard-x86_64.AppImage

# MOZILLA FIREFOX
install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
rm /etc/apt/sources.list.d/mozilla.list
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | tee /etc/apt/preferences.d/mozilla
apt update && apt install firefox firefox-l10n-fr

# UPSCAYL 
if [[ "$INSTALLER_UPSCAYL" -eq 1 ]]; then
	wget https://github.com/upscayl/upscayl/releases/download/v2.11.5/upscayl-2.11.5-linux.AppImage -P /etc/fenikkusu/openbox-scripts -c
	chmod +x /etc/fenikkusu/openbox-scripts/upscayl-2.11.5-linux.AppImage
fi

# VLC
apt install vlc

cp apps-bureautique-icones/* /etc/fenikkusu/openbox-icons/

echo " "
echo "###################################"
echo "# APPS INSTALLEES"
echo "###################################"
echo " "
echo "Vous pouvez ajouter ces informations pour configurer votre menu désormais."
echo "- Menu > Configurer Le Menu"
echo "Puis dans l'application, ouvrir le fichier '.config/openbox/debian-menu.xml' de votre dossier Utilisateur."
echo " "
echo "GIMP :"
echo "- Catégorie suggérée : Graphisme"
echo "- Nom suggéré : GIMP"
echo "- Executable : /usr/bin/gimp"
echo "- Icone : /etc/fenikkusu/openbox-icons/gimp.svg"
echo " "
echo "Inkscape :"
echo "- Catégorie suggérée : Graphisme"
echo "- Nom suggéré : Inkscape"
echo "- Executable : /usr/bin/inkscape"
echo "- Icone : /etc/fenikkusu/openbox-icons/inkscape.svg"
echo " "
echo "LibreOffice :"
echo "- Catégorie suggérée : Bureautique"
echo "- Nom suggéré : LibreOffice"
echo "- Executable : /etc/fenikkusu/openbox-scripts/LibreOffice-still.standard-x86_64.AppImage"
echo "- Icone : /etc/fenikkusu/openbox-icons/libreoffice.svg"
echo " "
echo "Mozilla Firefox :"
echo "- Catégorie suggérée : Internet"
echo "- Nom suggéré : Mozilla Firefox"
echo "- Executable : /usr/bin/firefox"
echo "- Icone : /etc/fenikkusu/openbox-icons/firefox.svg"
if [[ "$INSTALLER_UPSCAYL" -eq 1 ]]; then
	echo " "
	echo "Upscayl :"
	echo "- Catégorie suggérée : Graphisme"
	echo "- Nom suggéré : Upscayl"
	echo "- Executable : /etc/fenikkusu/openbox-scripts/upscayl-2.11.5-linux.AppImage"
	echo "- Icone : /etc/fenikkusu/openbox-icons/upscayl.png"
fi
echo " "
echo "VLC :"
echo "- Catégorie suggérée : Multimédia"
echo "- Nom suggéré : VLC Media Player"
echo "- Executable : /usr/bin/vlc"
echo "- Icone : /etc/fenikkusu/openbox-icons/vlc.svg"
