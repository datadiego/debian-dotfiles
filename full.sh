#!/bin/bash

# nombre y usuario para git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

# instalar i3-gaps
sudo apt update && sudo apt install -y curl build-essential xdotool git meson ninja-build autoconf automake libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinerama0-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm-dev libxcb-shape0-dev pkg-config libxcb-xfixes0-dev libxcb-xinerama0-dev libxcb-xkb-dev xutils-dev libtool && \
cd /tmp && git clone https://github.com/Airblader/i3 i3-gaps && cd i3-gaps && mkdir -p build && cd build && meson .. && ninja && sudo ninja install

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

cp ./dotfiles/i3 ~/.config/i3/config
cp ./dotfiles/terminal-preserving-working-directory.sh ~/.config/i3/terminal-preserving-working-directory.sh
cp ./dotfiles/keybindings.conf ~/.config/i3/keybindings.conf

cp ./dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml

cp ./dotfiles/polybar-config.ini ~/.config/polybar/config.ini

cp ./dotfiles/bashrc ~/.bashrc

cp ./dotfiles/dracula.omp.json ~/.config/oh-my-posh/dracula.omp.json

# Verificar si snap está instalado
if command -v snap &> /dev/null
then
    echo "Snap está instalado, continuando con las operaciones de snap..."
    sudo snap remove firefox
    sudo snap install --classic code
else
    echo "Snap no está instalado. Se omiten las operaciones de snap."
fi

code --install-extension hilalh.hyper-dracula-vscode-theme

cp dotfiles/code.settings.json ~/.config/Code/User/settings.json

# Instalación de paquetes para Debian/Ubuntu
sudo apt update
sudo apt install -y chromium sqlite3 eza npm nodejs micro yq jq csvkit httpie lazygit tree 

# Instalar paquetes npm globalmente
sudo npm i -g opencode-ai@latest live-server

# Copiar el acceso directo de chatgpt.desktop
cp apps/chatgpt.desktop ~/.local/share/applications/

# instalar fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all