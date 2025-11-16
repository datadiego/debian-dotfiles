#!/bin/bash

# nombre y usuario para git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

# instalar i3-gaps
sudo apt update && sudo apt install -y curl build-essential xdotool git meson ninja-build autoconf automake libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinerama0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm-dev libxcb-shape0-dev pkg-config libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xkb-dev xutils-dev libtool && \
cd /tmp && git clone https://github.com/Airblader/i3 i3-gaps && cd i3-gaps && mkdir -p build && cd build && meson .. && ninja && sudo ninja install

# Carpetas para gestor de ventanas en ubuntu 25.05
mkdir /usr/local/share/applications
mkdir /usr/local/share/xsessions
mkdir /usr/share/applications
mkdir /usr/share/xsessions

cp dotfiles/i3.desktop /usr/local/share/applications/
cp dotfiles/i3.desktop /usr/local/share/xsessions/
cp dotfiles/i3.desktop /usr/share/applications/
cp dotfiles/i3.desktop /usr/share/xsessions/

# instalar picom

sudo apt install -y picom

# instalar rofi
sudo apt install -y rofi

# instalar y configurar polybar
sudo apt install polybar -y

# instalar gh-cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# intalar scrot para screenshots
sudo apt install scrot -y

# instalar alacritty, fuentes y oh-my-posh
sudo apt install -y alacritty
sudo apt install fonts-firacode
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v
curl -s https://ohmyposh.dev/install.sh | bash -s

# directorios para configuraciones
mkdir ~/.config/i3
mkdir ~/.config/polybar
mkdir ~/.config/alacritty
mkdir ~/.config/oh-my-posh

# configuracion de variables de git
git config --global user.name "$git_name"
git config --global user.email "$git_email"

gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'es+nodeadkeys')]"
gsettings set org.gnome.desktop.input-sources current 0
