#!/bin/bash
#
# Applications : Jeux
# Projet Fenikkusu
#
# Applications nécessaires :
# - Firefox
#
# Applications optionnelles :
# - Debreate
# - Geany
# - Github Desktop
#
# Variables modifiables ( 1=Oui, 0=Non )
INSTALLER_DEBREATE=1
INSTALLER_GEANY=1
INSTALLER_GITHUBDESKTOP=1



# DEBREATE 
if [[ "$INSTALLER_DEBREATE" -eq 1 ]]; then
	apt install python3 python3-wxgtk-webview4.0 python3-wxgtk4.0 fakeroot dpkg util-linux debianutils
	./megadl.sh https://mega.nz/file/Yn1SGbJa#yK2e6ZPw3Hvu6uxTN3nPfUl-IX7MiiGFah-hj1_reZ0
	dpkg -i /etc/fenikkusu/openbox-scripts/debreate_0.8-dev9_all.deb
fi

# GEANY 
if [[ "$INSTALLER_GEANY" -eq 1 ]]; then
	apt install geany
fi

# GITHUB DESKTOP 
if [[ "$INSTALLER_GITHUBDESKTOP" -eq 1 ]]; then
	wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
	sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
	apt update && apt install github-desktop
fi

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

cp apps-programmation-icones/* /etc/fenikkusu/openbox-icons/

echo " "
echo "###################################"
echo "# APPS INSTALLEES"
echo "###################################"
echo " "
echo "Vous pouvez ajouter ces informations pour configurer votre menu désormais."
echo "- Menu > Configurer Le Menu"
echo "Puis dans l'application, ouvrir le fichier '.config/openbox/debian-menu.xml' de votre dossier Utilisateur."
if [[ "$INSTALLER_DEBREATE" -eq 1 ]]; then
	echo " "
	echo "Debreate :"
	echo "- Catégorie suggérée : Programmation"
	echo "- Nom suggéré : Debreate"
	echo "- Executable : /usr/bin/debreate"
	echo "- Icone : /etc/fenikkusu/openbox-icons/debreate.svg"
fi
if [[ "$INSTALLER_GEANY" -eq 1 ]]; then
	echo " "
	echo "Geany :"
	echo "- Catégorie suggérée : Programmation"
	echo "- Nom suggéré : Geany"
	echo "- Executable : /usr/bin/geany"
	echo "- Icone : /etc/fenikkusu/openbox-icons/geany.svg"
fi
if [[ "$INSTALLER_GITHUBDESKTOP" -eq 1 ]]; then
	echo " "
	echo "Github Desktop :"
	echo "- Catégorie suggérée : Programmation"
	echo "- Nom suggéré : Github Desktop"
	echo "- Executable : /usr/bin/github-desktop"
	echo "- Icone : /etc/fenikkusu/openbox-icons/github.svg"
fi
echo " "
echo "Mozilla Firefox :"
echo "- Catégorie suggérée : Internet"
echo "- Nom suggéré : Mozilla Firefox"
echo "- Executable : /usr/bin/firefox"
echo "- Icone : /etc/fenikkusu/openbox-icons/firefox.svg"

