#!/bin/bash

set -e

WORKDIR="$(cd "$(dirname "$0")" && pwd)"

# Configurar git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

sudo apt update
sudo apt install curl bspwm sxhkd git unzip -y || true


# Otras aplicaciones del entorno
sudo apt install -y picom || true
sudo apt install -y feh || true
sudo apt install -y rofi || true
sudo apt install -y polybar || true
sudo apt install -y alacritty || true
sudo apt install -y bpytop || true
sudo apt install -y brightnessctl || true
sudo apt install -y pulseaudio-utils || true

# Nerd fonts
sudo apt install -y fonts-firacode || true
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

# oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Directorios de configuraciones
mkdir -p ~/.config/polybar
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/oh-my-posh
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/Code/User
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd
mkdir -p ~/.config/wallpapers
mkdir -p ~/.config/picom

# Copiar dotfiles

cp "$WORKDIR/dotfiles/alacritty.toml" ~/.config/alacritty/

cp "$WORKDIR/dotfiles/polybar-config.ini" ~/.config/polybar/config.ini

cp "$WORKDIR/dotfiles/bashrc" ~/.bashrc

cp "$WORKDIR/dotfiles/dracula.omp.json" ~/.config/oh-my-posh/dracula.omp.json

cp "$WORKDIR/apps/chatgpt.desktop" ~/.local/share/applications/

cp "$WORKDIR/dotfiles/bspwmrc" ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc

cp "$WORKDIR/dotfiles/bspwm-resize.sh" ~/.config/bspwm/bspwm-resize.sh
chmod +x ~/.config/bspwm/bspwm-resize.sh

cp "$WORKDIR/dotfiles/sxhkdrc" ~/.config/sxhkd/sxhkdrc
chmod +x ~/.config/sxhkd/sxhkdrc

cp "$WORKDIR/apps/keys" ~/.local/bin/helpkeys
chmod +x ~/.local/bin/helpkeys

cp "$WORKDIR/imgs/wallpaper.jpg" ~/.config/wallpapers/wallpaper.jpg

cp "$WORKDIR/dotfiles/picom.conf" ~/.config/picom/picom.conf

# Configurar permisos de brillo (backlight)
echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules > /dev/null
sudo usermod -aG video $USER
sudo udevadm control --reload-rules
sudo udevadm trigger

# Ajustes gnome
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'es+nodeadkeys')]"
gsettings set org.gnome.desktop.input-sources current 0

# Instalacion gh-cli
(type -p wget >/dev/null || sudo apt install -y wget)

sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp)
wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg

sudo cp "$out" /etc/apt/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

sudo mkdir -p -m 755 /etc/apt/sources.list.d
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt update
sudo apt install -y gh || true

# Aplicaciones de snap
if command -v snap &> /dev/null; then
    echo "Snap detectado, ejecutando acciones..."
    sudo snap remove firefox || true
    sudo snap install --classic code
else
    echo "Snap NO está instalado, saltando sección."
fi

# TODO: Instalar vscode desde .deb

# Configuracion VScode
code --install-extension hilalh.hyper-dracula-vscode-theme
cp "$WORKDIR/dotfiles/code.settings.json" ~/.config/Code/User/settings.json

# Otros paquetes
sudo apt-get install -y wget || true
sudo apt-get install -y xclip || true
sudo apt-get install -y chromium || true
sudo apt-get install -y sqlite3 || true
sudo apt-get install -y eza || true
sudo apt-get install -y npm || true
sudo apt-get install -y nodejs || true
sudo apt-get install -y micro || true
sudo apt-get install -y yq || true
sudo apt-get install -y jq || true
sudo apt-get install -y csvkit || true
sudo apt-get install -y httpie || true
sudo apt-get install -y lazygit || true
sudo apt-get install -y tree || true
sudo apt-get install -y tor || true
sudo apt-get install -y torsocks || true
sudo apt-get install -y proxychains || true
sudo apt-get install -y nmap || true
sudo apt-get install -y arandr || true
sudo apt-get install -y screenkey || true
sudo apt-get install -y flameshot || true
sudo apt-get install -y ffmpeg || true
sudo apt-get install -y mitmproxy || true

# configuraciones aplicaciones
mkdir -p ~/.config/micro/
mkdir -p ~/.config/micro/colorschemes
cp "$WORKDIR/dotfiles/dracula.micro" ~/.config/micro/colorschemes/dracula.micro

# Discord
wget https://discord.com/api/download?platform=linux -O discord.deb
sudo apt install -y ./discord.deb || true
rm discord.deb

# Netbeans
# wget https://www.apache.org/dyn/closer.lua/netbeans/netbeans/28/netbeans-28-bin.zip?action=download -O netbeans.zip
# unzip -q netbeans.zip -d "$HOME/Applications/"
# rm netbeans.zip

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Paquetes npm globales
sudo npm i -g opencode-ai@latest live-server

# Instalacion FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# Font Awesome 6 para icono de bateria
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
FA6_URL="https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip"
TMP_DIR=$(mktemp -d)
wget -qO "$TMP_DIR/fa6.zip" "$FA6_URL"
unzip -q "$TMP_DIR/fa6.zip" -d "$TMP_DIR"
OTF_DIR=$(find "$TMP_DIR" -type d -name "otfs")
if [ -d "$OTF_DIR" ]; then
    echo "Copiando fuentes a $FONT_DIR..."
    cp "$OTF_DIR"/*.otf "$FONT_DIR/"
else
    echo "No se encontraron archivos .otf en el ZIP. Comprueba la URL o versión."
    exit 1
fi
fc-cache -fv > /dev/null
rm -rf "$TMP_DIR"


# aichat-ng
# curl https://sh.rustup.rs -sSf | sh -s -- -y
# export PATH="$HOME/.cargo/bin:$PATH"
# grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
# TMPDIR=$(mktemp -d)
# git clone https://github.com/blob42/aichat-ng.git "$TMPDIR/aichat-ng"
# cd "$TMPDIR/aichat-ng"
# cargo install --path .

# aichatng --version || echo "AIChat-NG instalado, verifica ejecutando: aichatng"

# cd "$WORKDIR"
# rm -rf "$TMPDIR"

# docker
sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
sudo apt update
sudo apt install -y ca-certificates curl || true
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || true

# obs
sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update
sudo apt install -y obs-studio || true

echo "Instalación completada con éxito."