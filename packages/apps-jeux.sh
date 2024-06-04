#!/bin/bash
#
# Applications : Jeux
# Projet Fenikkusu
#
# Applications nécessaires :
# - Firefox
#
# Applications optionnelles :
# - Lutris
# - Mcpelauncher
# - Steam
#
# Variables modifiables ( 1=Oui, 0=Non )
INSTALLER_LUTRIS=1
INSTALLER_MCPELAUNCHER=1
INSTALLER_STEAM=1



# LUTRIS 
if [[ "$INSTALLER_LUTRIS" -eq 1 ]]; then
	apt install python3-yaml python3-lxml python3-requests python3-magic gir1.2-webkit2-4.1 cabextract fluid-soundfont-gs vulkan-tools
	wget https://github.com/lutris/lutris/releases/download/v0.5.17/lutris_0.5.17_all.deb -P /etc/fenikkusu/openbox-scripts -c
	dpkg -i /etc/fenikkusu/openbox-scripts/lutris_0.5.17_all.deb
fi

# MCPELAUNCHER 
if [[ "$INSTALLER_MCPELAUNCHER" -eq 1 ]]; then
	curl -sS https://minecraft-linux.github.io/pkg/deb/pubkey.gpg | tee -a /etc/apt/trusted.gpg.d/minecraft-linux-pkg.asc
	echo "deb [arch=amd64,arm64,armhf] https://minecraft-linux.github.io/pkg/deb bookworm main" | tee /etc/apt/sources.list.d/minecraft-linux-pkg.list
	apt update && apt install mcpelauncher-ui-manifest mcpelauncher-manifest-glfw
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

# STEAM
if [[ "$INSTALLER_STEAM" -eq 1 ]]; then
	apt install python3-apt
	wget https://cdn.akamai.steamstatic.com/client/installer/steam.deb -P /etc/fenikkusu/openbox-scripts -c
	dpkg -i /etc/fenikkusu/openbox-scripts/steam.deb
fi

cp apps-jeux-icones/* /etc/fenikkusu/openbox-icons/

echo " "
echo "###################################"
echo "# APPS INSTALLEES"
echo "###################################"
echo " "
echo "Vous pouvez ajouter ces informations pour configurer votre menu désormais."
echo "- Menu > Configurer Le Menu"
echo "Puis dans l'application, ouvrir le fichier '.config/openbox/debian-menu.xml' de votre dossier Utilisateur."
if [[ "$INSTALLER_LUTRIS" -eq 1 ]]; then
	echo " "
	echo "Lutris :"
	echo "- Catégorie suggérée : Jeux"
	echo "- Nom suggéré : Lutris"
	echo "- Executable : /usr/games/lutris"
	echo "- Icone : /etc/fenikkusu/openbox-icons/lutris.svg"
fi
if [[ "$INSTALLER_MCPELAUNCHER" -eq 1 ]]; then
	echo " "
	echo "Mcpelauncher :"
	echo "- Catégorie suggérée : Jeux"
	echo "- Nom suggéré : Minecraft Bedrock Edition"
	echo "- Executable : /usr/bin/mcpelauncher-ui-qt"
	echo "- Icone : /etc/fenikkusu/openbox-icons/minecraft.svg"
fi
echo " "
echo "Mozilla Firefox :"
echo "- Catégorie suggérée : Internet"
echo "- Nom suggéré : Mozilla Firefox"
echo "- Executable : /usr/bin/firefox"
echo "- Icone : /etc/fenikkusu/openbox-icons/firefox.svg"
if [[ "$INSTALLER_STEAM" -eq 1 ]]; then
	echo " "
	echo "Steam :"
	echo "- Catégorie suggérée : Jeux"
	echo "- Nom suggéré : Steam"
	echo "- Executable : /usr/bin/steam"
	echo "- Icone : /etc/fenikkusu/openbox-icons/steam.svg"
fi
