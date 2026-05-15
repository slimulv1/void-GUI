#!/bin/bash
#The following script is for installing Cinnamon & Services after installing base-void (glibc)

#start bash - set for root
clear
echo "set rootshell to /bin/bash"
echo "Please give rootpassword"
su -c "chsh -s /bin/bash root"
sleep 2

#Activate sudo
clear
echo "Activate sudo for wheel-group"
echo "Please give rootpassword"
su -c 'echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers > /dev/null'
sleep 2

#Styling
clear
echo "Setting up Lightdm/Cinnamon backgroundimage"
echo " -- Please give sudo-password -- "
sudo mkdir -p /usr/share/backgrounds/
sudo cp ~/void/*.jpg /usr/share/backgrounds/

#copy automountscript für udisk2
sudo cp ~/void/mount_disks.sh /usr/bin/


#Check systemupdates
sudo xbps-install -Syu

#activate all essential Repos
clear
echo "Nonfree, multilib, multilib-nonfree aktivieren / Activate all essential additional repos"
sudo xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
sleep 2

#update voidrepository
sudo xbps-install -Syu

#Install editor
clear
echo "Install nano..."
sudo xbps-install -y nano
sleep 1

#Install recommended packages
sudo xbps-install curl wget git xz unzip zip nano vim gptfdisk xtools mtools mlocate ntfs-3g fuse-exfat bash-completion linux-headers gtksourceview4 ffmpeg mesa-vdpau mesa-vaapi htop

#Install development packages 
sudo xbps-install autoconf automake bison m4 make libtool flex meson ninja optipng sassc

#Netzwerk/Network
clear
echo "Install NetworkManager"
sudo xbps-install -y NetworkManager NetworkManager-openvpn NetworkManager-openconnect NetworkManager-vpnc NetworkManager-l2tp
sudo ln -s /etc/sv/NetworkManager /var/service/
sleep 1

#dbus
clear
echo "Install dbus..."
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service/
sleep 1

#elogind
clear
echo "Install elogind..."
sudo xbps-install -y elogind
sudo ln -s /etc/sv/elogind /var/service/
sleep 1

#Audio/bluetooth/Mixer
clear
echo "Install pipewire, wireplumber, pavucontrol, pulsemixer"
sudo xbps-install -y pipewire wireplumber pavucontrol pulsemixer libspa-bluetooth blueman bluez-cups
sleep 1

#Printing support configuration 
echo "Install Cups"
sudo xbps-install cups cups-pk-helper cups-filters foomatic-db foomatic-db-engine
echo "Enable CUPS service: "
sudo ln -sv /etc/sv/cupsd /var/service
echo "Install Epson Printer"
sudo xbps-install -Rs epson-inkjet-printer-escpr imagescan iscan-data
echo "Install HP Printer"
sudo xbps-install -Rs hplip-gui
echo "Install Cannon Printer"
sudo xbps-install -Rs cnijfilter2
echo "Install Brother Printer"
sudo xbps-install -Rs brother-brlaser
sleep 1

#Cron configuration
echo "Install cronie"
sudo xbps-install -y cronie
echo"Enable cronie service"
sudo ln -sv /etc/sv/cronie /var/service
sleep 1

#Notebook Power Saving configuration 
echo "Install TLP and PowerTop"
sudo xbps-install tlp tlp-rdw powertop
echo "Enable TLP service"
sudo ln -sv /etc/sv/tlp /var/service
sleep 1

#Office suite 
echo "Install LibreOffice"
sudo xbps-install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-draw libreoffice-math libreoffice-base libreoffice-gnome libreoffice-i18n-en-US
sleep 1

#Media player
echo "Install VLC Media Player"
sudo xbps-install vlc
sleep 1

#Logging Daemon activation
echo "By default, Void comes with no logging daemon"
sudo xbps-install -Rs socklog-void
sudo ln -s /etc/sv/socklog-unix /var/service/
sudo ln -s /etc/sv/nanoklogd /var/service/
sleep 1

#Profile Sync Daemon (PSD) 
echo "PSD is a service that symlinks & syncs browser profile directories to RAM, thus reducing HDD/SSD calls & speeding up browsers. You can get it from here. This helps Firefox & Chromium reduce ram usage"
git clone https://github.com/madand/runit-services
cd runit-services
sudo mv psd /etc/sv/
sudo ln -s /etc/sv/psd /var/service/
sudo chmod +x etc/sv/psd/*
cd ..
sleep 1

#Lazygit
echo "Simple terminal UI for git command"
sudo xbps-install -Su lazygit
sleep 1

#Neovim + AstroNvim
echo "Install Neovim"
sudo xbps-install -Su neovim
echo "Install AstroNvim"
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync
sleep 1 

#VSV 
echo "Manage and view runit services"
sudo xbps-install vsv 
sleep 1

#Install some Steam-related-Stuff
sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit
sleep 1

#Xlibre & Cinnamon & OctoXBPS & Tools
clear
echo "Install Xlibre/Cinnamon-all..."
sudo wget -O /var/db/xbps/keys/00:ca:42:57:c9:c0:9a:ec:94:b4:7d:97:e5:a9:aa:1e.plist https://github.com/xlibre-void/xlibre/raw/refs/heads/main/repo-keys/x86_64/00:ca:42:57:c9:c0:9a:ec:94:b4:7d:97:e5:a9:aa:1e.plist
sudo mkdir -p /etc/xbps.d
printf "repository=https://github.com/xlibre-void/xlibre/releases/latest/download/\n" | sudo tee /etc/xbps.d/99-repository-xlibre.conf
sudo xbps-install -S
sudo xbps-install -Su xlibre
sudo xbps-install -y octoxbps cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
sleep 1

#Docker
echo "Install docker"
sudo xbps-install -Su docker
echo "Enable required services"
sudo ln -s /etc/sv/containerd /var/service
sudo ln -s /etc/sv/docker /var/service
echo "Add user to group"
sudo groupadd docker
sudo usermod -aG docker ${USER}
echo "Set respective permissions"
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sleep 1

#Nix package manager 
clear
echo "Install Nix"
sudo xbps-install -Sy nix
echo "Activate Nix Daemon"
sudo ln -s /etc/sv/nix-daemon /var/service/
source /etc/profile
echo "Add channels"
echo "Unstable" 
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
echo "NixOS 25.11"
nix-channel --add https://nixos.org/channels/nixos-25.11 nixpkgs
echo "Update channels" 
nix-channel --update
echo "List channels"
nix-channel --list 
echo "To see installed applications in the launcher create a symlink to Nix applications directory"
sudo ln -s "$HOME/.nix-profile/share/applications" "$HOME/.local/share/applications/nix-env"
sleep 1

#Dconf Editor 
echo "Applications internal settings viewer and editor"
sudo xbps-install dconf-editor
sleep 1

#Syncthing 
echo "Install Syncthing"
sudo xbps-install -Rs syncthing 
echo "Starting Syncthing automatically when system starts"
sudo cp /usr/share/applications/syncthing-start.desktop ~/.config/autostart/
sleep 1

#Intel's Microcode 
echo "Install Intel's Microcode"
sudo xbps-install -Rs intel-ucode 
echo "Reconfigure your kernel, according your kernel name"
sudo xbps-reconfigure -f linux6.12
sleep 1

#

#Printersupport
clear
echo "Install Cups"
sudo xbps-install cups cups-pk-helper cups-filters foomatic-db foomatic-db-engine gutenprint system-config-printer
sudo xbps-install -y gnome-system-tools users-admin
echo "Enable CUPS service: "
sudo ln -sv /etc/sv/cupsd /var/service
echo "Install Epson Printer"
sudo xbps-install -Rs epson-inkjet-printer-escpr imagescan iscan-data
echo "Install HP Printer"
sudo xbps-install -Rs hplip-gui
echo "Install Cannon Printer"
sudo xbps-install -Rs cnijfilter2
echo "Install Brother Printer"
sudo xbps-install -Rs brother-brlaser
sleep 1

#Filesystem
clear
echo "Install Zusatztools/Installing additional tools..."
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk bluez
#Aktiviere bluetoothd/activate bluetoothd
sudo ln -s /etc/sv/bluetoothd /var/service/
sleep 1

#Flatpak / Upgradetool
clear
echo "Install Flatpak / topgrade..."
sudo xbps-install -y flatpak topgrade
sleep 1

#Fonts
clear
echo "Install Fonts..."
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra
sleep 1

#Software
clear
echo "Install Software..."
sudo xbps-install -y firefox gnome-terminal firefox-i18n-vi
sleep 1
# Create a script that executes gsettings after login.
echo "Creating autostart script for cinnamon theme settings..."
cat <<EOL > /home/$USER/set-cinnamon-theme.sh
#!/bin/bash
# Setze das gewünschte Cinnamon-Theme & deutsches Tastaturlayout
gsettings set org.cinnamon.desktop.interface icon-theme Arc
gsettings set org.cinnamon.desktop.interface gtk-theme Arc-Dark
gsettings set org.cinnamon.theme name Arc-Dark
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'us')]"
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 11'
gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/cinnamon_background.jpg'


# Delete the autostart entry after the first execution.
rm -f ~/.config/autostart/set-cinnamon-theme.desktop

# Display a message indicating that the script has finished.
echo "Cinnamon themes were set and the autostart entry was removed."
EOL

# Make sure the script is executable.
chmod +x /home/$USER/set-cinnamon-theme.sh

# Create the autostart file that will run the script.
mkdir -p ~/.config/autostart
cat <<EOL > ~/.config/autostart/set-cinnamon-theme.desktop
[Desktop Entry]
Type=Application
Exec=/home/$USER/set-cinnamon-theme.sh
Name=Set Cinnamon Theme
Comment=Set the default Cinnamon theme after login
X-GNOME-Autostart-enabled=true
EOL

# create .desktopfile for octoxbps-notifier
cat > ~/.config/autostart/octoxbps-notifier.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/bin/octoxbps-notifier
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=OctoXBPS Notifier
Comment=Startet OctoXBPS Update Notifier automatisch
EOL

# .create .desktopfile für english-X11-keyboard
# Please remove this autostart-entry if you would like to set the keyboardlayout directly in Cinnamon
cat > ~/.config/autostart/x11kb-english.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/usr/bin/setxkbmap us
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=X11-KB-English
Comment=Activate English keyboard under X11
EOL

# create .desktopfile for auto-mount script (for udisks2)
# Please remove this autostart-entry if you would like to set the keyboardlayout directly in Cinnamon
cat > ~/.config/autostart/automount-udisks2.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=/usr/bin/mount_disks.sh 
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=X11-automount-udisks2
Comment=Automount script for udisks2
EOL


# Continue with further installations or to the end of the script
echo "Cinnamon-Theme Autostart-Skript erstellt. Skript beendet."

#Loginmanager
clear
echo "Install LightDM..."
sudo xbps-install -y lightdm lightdm-gtk-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/
sleep 1

#Cinnamon-Themes
clear
echo "Install ArcTheme / Arc-icons..."
sudo xbps-install -y arc-icon-theme arc-theme
sleep 1

# Add the desired settings to the LightDM configuration.
echo "theme-name=Arc-Dark" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "icon-theme-name=Arc" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "background=/usr/share/backgrounds/lightdmbackground.jpg" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null

#Setup Autostart - pipewire & wireplubmer

sudo mkdir -p /etc/pipewire/pipewire.conf.d

sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# do not activate the following line. pipewire stops working if so!
#sudo ln -s /usr/share/applications/wireplumber.desktop /etc/xdg/autostart/
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/
sleep 1
clear
#Activate english keyboard for X11
echo "de_DE" > "$HOME/.config/user-dirs.locale"

#setup automount for ssds/hdds - without fstab
sudo cp ~/void/10-mount-drives.rules /etc/polkit-1/rules.d/
clear
echo "Setup finished - please reboot"
echo "use sudo reboot"
