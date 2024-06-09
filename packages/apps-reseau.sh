#!/bin/bash
#
# Applications : Réseau
# Projet Fenikkusu
#
# Applications nécessaires :
# - Ettercap
# - Firefox
# - Hydra
# - John the Ripper
# - Lynis
# - Nikto
# - Nmap
# - Sqlmap
# - Wireshark

# Ettercap 
apt install ethtool ettercap-common ettercap-graphical

# Hydra 
apt install hydra hydra-gtk

# John the Ripper 
apt install john john-data

# Lynis 
apt install lynis

# Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
chmod 755 msfinstall && \
./msfinstall
rm -dR ./msfinstall

# Nikto 
apt install nikto

# NMAP 
apt install nmap nmapsi4

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

# SQLMAP 
apt install sqlmap

# Wireshark 
apt install wireshark

cp apps-programmation-icones/* /etc/fenikkusu/openbox-icons/

echo " "
echo "###################################"
echo "# APPS INSTALLEES"
echo "###################################"
echo " "
echo "Ettercap :"
echo "- Executable : /usr/bin/ettercap"
echo " "
echo "Hydra :"
echo "- Executable : /usr/bin/hydra"
echo " "
echo "John the Ripper :"
echo "- Executable : /usr/sbin/john"
echo " "
echo "Lynis :"
echo "- Executable : /usr/sbin/lynis"
echo " "
echo "Metasploit :"
echo "- Executable : /opt/metasploit-framework/bin/msfconsole"
echo " "
echo "Nikto :"
echo "- Executable : /usr/bin/nikto"
echo " "
echo "Nmap :"
echo "- Executable : /usr/bin/nmap"
echo " "
echo "Sqlmap :"
echo "- Executable : /usr/bin/sqlmap"
echo " "
echo "Vous pouvez ajouter ces informations pour configurer votre menu désormais."
echo "- Menu > Configurer Le Menu"
echo "Puis dans l'application, ouvrir le fichier '.config/openbox/debian-menu.xml' de votre dossier Utilisateur."
echo " "
echo "Hydra :"
echo "- Catégorie suggérée : Réseau"
echo "- Nom suggéré : Hydra"
echo "- Executable : /usr/bin/xhydra"
echo "- Icone : /etc/fenikkusu/openbox-icons/hydra.svg"
echo " "
echo "Nmapsi4 :"
echo "- Catégorie suggérée : Réseau"
echo "- Nom suggéré : Nmapsi4"
echo "- Executable : /usr/bin/nmapsi4"
echo "- Icone : /etc/fenikkusu/openbox-icons/nmapsi4.svg"
echo " "
echo "Mozilla Firefox :"
echo "- Catégorie suggérée : Internet"
echo "- Nom suggéré : Mozilla Firefox"
echo "- Executable : /usr/bin/firefox"
echo "- Icone : /etc/fenikkusu/openbox-icons/firefox.svg"
echo " "
echo "Wireshark :"
echo "- Catégorie suggérée : Réseau"
echo "- Nom suggéré : Wireshark"
echo "- Executable : /usr/bin/wireshark"
echo "- Icone : /etc/fenikkusu/openbox-icons/wireshark.svg"

