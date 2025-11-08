#!/bin/bash

# Delete default softwares
dnf remove -y gnome-tour gnome-help firefox libreoffice-writer libreoffice-calc libreoffice-impress

# Install gnome extensions
# dash-to-dock@micxgx.gmail.com
# wget https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v102.shell-extension.zip 
# gnome-extensions install dash-to-dockmicxgx.gmail.com.v102.shell-extension.zip
# rm dash-to-dockmicxgx.gmail.com.v102.shell-extension.zip

# arcmenu@arcmenu.com
# wget https://extensions.gnome.org/extension-data/arcmenuarcmenu.com.v69.shell-extension.zip
# gnome-extensions install https://extensions.gnome.org/extension-data/arcmenuarcmenu.com.v69.shell-extension.zip
# rm arcmenuarcmenu.com.v69.shell-extension.zip

# https://extensions.gnome.org/extension/615/appindicator-support/?ref=itsfoss.com

# GNOME Configuration
dnf install -y dconf-editor gnome-tweaks gnome-builder papirus-icon-theme.noarch

dconf reset -f /

dconf write /org/gnome/shell/disable-user-extensions false
dconf write /org/gnome/shell/enabled-extensions "['background-logo@fedorahosted.org', 'dash-to-dock@micxgx.gmail.com', 'arcmenu@arcmenu.com']"
dconf write /org/gnome/shell/favorite-apps "['org.gnome.Ptyxis.desktop', 'org.pipewire.Helvum.desktop', 'org.gnome.Nautilus.desktop', 'com.vivaldi.Vivaldi.desktop', 'org.mozilla.Thunderbird.desktop', 'org.zotero.Zotero.desktop', 'org.texstudio.TeXstudio.desktop', 'org.gnome.Builder.desktop', 'com.plexamp.Plexamp.desktop', 'org.musescore.MuseScore.desktop', 'mod-desktop.desktop', 'com.valvesoftware.Steam.desktop']"

dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
dconf write /org/gnome/desktop/interface/accent-color "'green'"
dconf write /org/gnome/desktop/interface/show-battery-percentage true
dconf write /org/gnome/builder/editor/language/fortran/show-right-margin false
dconf write /org/gnome/builder/editor/language/fortran/tab-width 4
dconf write /org/gnome/desktop/interface/icon-theme "'Papirus'"

dconf write /org/gnome/builder/editor/language/sh/show-right-margin false
dconf write /org/gnome/builder/editor/language/sh/tab-width 4
dconf write /org/gnome/builder/editor/show-grid-lines true
dconf write /org/gnome/builder/editor/font-name "'Monospace 9'"

dconf write /org/gnome/mutter/experimental-features "['scale-monitor-framebuffer', 'variable-refresh-rate', 'xwayland-native-scaling']"

dconf write /org/gnome/desktop/wm/preferences/button-layout "'icon:minimize,maximize,close'"
dconf write /org/gnome/desktop/session/idle-delay 0

dconf write /org/gnome/shell/extensions/arcmenu/menu-layout "'Zest'"
dconf write /org/gnome/shell/extensions/arcmenu/show-activities-button true
dconf write /org/gnome/shell/extensions/arcmenu/menu-button-position-offset 1

dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed true

dconf write /org/gnome/shell/weather/automatic-location true
dconf write /org/gnome/shell/weather/locations "[<(uint32 2, <('Nice', 'LFMN', true, [(0.76183621849552485, 0.12566370614359174)], [(0.76270888312152207, 0.1265363707695889)])>)>]"
dconf write /org/gnome/desktop/interface/clock-format "'24h'"
dconf write /org/gnome/desktop/interface/clock-show-weekday true

/org/gnome/settings-daemon/plugins/power/

# Change PP
sudo wget https://perso.matheor.com/thomas-jacumin/resources/images/photo.png -O  /var/lib/AccountsService/icons/thomas

# alphabetical order app
gsettings set org.gnome.shell app-picker-layout "[]"

# Flatpak
dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub org.pipewire.Helvum -y
flatpak install flathub org.mozilla.Thunderbird -y
flatpak install flathub com.vivaldi.Vivaldi -y
flatpak install flathub org.torproject.torbrowser-launcher -y
flatpak install flathub com.nextcloud.desktopclient.nextcloud -y
flatpak install flathub org.libreoffice.LibreOffice -y

flatpak install flathub org.texstudio.TeXstudio -y
flatpak install flathub org.zotero.Zotero -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.inkscape.Inkscape -y
flatpak install flathub org.paraview.ParaView -y

flatpak install flathub tv.plex.PlexDesktop -y
flatpak install flathub com.plexamp.Plexamp -y

# flatpak install flathub org.ardour.Ardour -y
flatpak install flathub io.jamulus.Jamulus -y
flatpak install flathub org.musescore.MuseScore -y

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.kde.kdenlive -y

flatpak install flathub com.valvesoftware.Steam -y

flatpak install flathub org.signal.Signal -y
flatpak install flathub chat.delta.desktop -y
flatpak install flathub us.zoom.Zoom -y

dnf install -y ardour8

# Mod-desktop
wget https://github.com/mod-audio/mod-desktop/releases/download/0.0.12/mod-desktop-0.0.12-linux-x86_64.tar.xz
wget https://raw.githubusercontent.com/mod-audio/mod-desktop/refs/heads/main/res/mod-logo.ico
sudo tar xvf mod-desktop-0.0.12-linux-x86_64.tar.xz -C /opt/
sudo mv mod-logo.ico /opt/mod-desktop-0.0.12-linux-x86_64/mod-logo.ico
sudo chown -R thomas:thomas /opt/mod-desktop-0.0.12-linux-x86_64
mv /opt/mod-desktop-0.0.12-linux-x86_64/mod-desktop.desktop ~/.local/share/applications/
sed -i 's|Exec=bash -c .*mod-desktop.run|Exec=/opt/mod-desktop-0.0.12-linux-x86_64/mod-desktop.run|' ~/.local/share/applications/mod-desktop.desktop
sed -i 's|Icon=audio|Icon=/opt/mod-desktop-0.0.12-linux-x86_64/mod-logo.ico|' ~/.local/share/applications/mod-desktop.desktop
rm mod-desktop-0.0.12-linux-x86_64.tar.xz

# limits.config
LIMITS_FILE="/etc/security/limits.d/99-audio.conf"
cat > "$LIMITS_FILE" <<EOF
# Allow unlimited locked memory for Ardour/JACK
@audio - rtprio 95
@audio - memlock unlimited
EOF

usermod -aG audio thomas

# build-utils
dnf group install -y c-development development-tools gcc-gfortran

# Git config
git config --global user.email "thomas.jacumin@matheor.com"
git config --global user.name "Thomas Jacumin"

# zsh
dnf install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
sed -i '/ZSH_THEME="robbyrussell"/c\ZSH_THEME="agnoster"' ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)' ~/.zshrc