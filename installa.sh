#!/bin/bash

# Guardar la ruta del directorio actual
CURRENT_DIR=$(pwd)

# 1. Instalar dependencias necesarias para i3-gaps
sudo apt update && sudo apt install -y build-essential xdotool git meson ninja-build autoconf automake \
libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libev-dev \
libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xinerama0-dev libstartup-notification0-dev \
libxcb-randr0-dev libxcb-xrm-dev libxcb-shape0-dev pkg-config libxcb-xfixes0-dev libxcb-xinerama0-dev \
libxcb-xkb-dev xutils-dev libtool

# 2. Clonar el repositorio i3-gaps
cd /tmp
git clone https://github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson .. && ninja && sudo ninja install

# 3. Instalar y configurar Polybar
sudo apt install polybar -y
mkdir -p ~/.config/polybar
cp /tmp/debian-dotfiles/dotfiles/polybar-config.ini ~/.config/polybar/config.ini

# 4. Instalar gh-cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

# 5. Crear directorios de configuración
mkdir -p ~/.config/i3
mkdir -p ~/.config/alacritty

# 6. Copiar los dotfiles desde el repositorio clonado
cp /tmp/debian-dotfiles/dotfiles/i3 ~/.config/i3/config
cp /tmp/debian-dotfiles/dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
cp /tmp/debian-dotfiles/dotfiles/new_terminal.sh ~/.config/i3/new_terminal.sh

# 7. Eliminar el repositorio clonado para limpiar
rm -rf /tmp/debian-dotfiles

echo "Instalación completa. El repositorio ha sido eliminado."
