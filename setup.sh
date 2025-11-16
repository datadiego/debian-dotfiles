#!/bin/bash

set -e

# Capturar directorio del proyecto
WORKDIR="$(cd "$(dirname "$0")" && pwd)"
echo "Directorio del proyecto: $WORKDIR"

# Configurar git
read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

# i3-gaps
sudo apt update
sudo apt install -y \
  curl build-essential xdotool git meson ninja-build autoconf automake \
  libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
  libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev \
  libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinerama0-dev \
  libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm-dev \
  libxcb-shape0-dev pkg-config libxcb-xfixes0-dev xutils-dev libtool

cd /tmp
rm -rf i3-gaps
git clone https://github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build
cd build
meson ..
ninja
sudo ninja install

# Otras aplicaciones del entorno
sudo apt install -y picom rofi polybar scrot alacritty

# Nerd fonts
sudo apt install -y fonts-firacode
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

# oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

# Directorios de configuraciones
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/oh-my-posh
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/Code/User

# Copiar dotfiles
cp "$WORKDIR/dotfiles/i3" ~/.config/i3/config
cp "$WORKDIR/dotfiles/terminal-preserving-working-directory.sh" ~/.config/i3/
cp "$WORKDIR/dotfiles/keybindings.conf" ~/.config/i3/

cp "$WORKDIR/dotfiles/alacritty.toml" ~/.config/alacritty/

cp "$WORKDIR/dotfiles/polybar-config.ini" ~/.config/polybar/config.ini

cp "$WORKDIR/dotfiles/bashrc" ~/.bashrc

cp "$WORKDIR/dotfiles/dracula.omp.json" ~/.config/oh-my-posh/dracula.omp.json

cp "$WORKDIR/apps/chatgpt.desktop" ~/.local/share/applications/

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
sudo apt install -y gh

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
sudo apt install -y xclip chromium sqlite3 eza npm nodejs micro yq jq csvkit httpie lazygit tree 

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
curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
TMPDIR=$(mktemp -d)
git clone https://github.com/blob42/aichat-ng.git "$TMPDIR/aichat-ng"
cd "$TMPDIR/aichat-ng"
cargo install --path .

aichatng --version || echo "AIChat-NG instalado, verifica ejecutando: aichatng"

cd "$WORKDIR"
rm -rf "$TMPDIR"

echo "Instalación completada con éxito."
