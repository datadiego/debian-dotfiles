#!/bin/bash

# Verificar si snap está instalado
if command -v snap &> /dev/null
then
    echo "Snap está instalado, continuando con las operaciones de snap..."
    sudo snap remove firefox
    sudo snap install --classic code
else
    echo "Snap no está instalado. Se omiten las operaciones de snap."
fi

# Instalación de paquetes para Debian/Ubuntu
sudo apt update
sudo apt install -y chromium sqlite3 eza npm nodejs micro

# Instalar paquetes npm globalmente
sudo npm i -g opencode-ai@latest live-server

# Copiar el acceso directo de chatgpt.desktop
cp apps/chatgpt.desktop ~/.local/share/applications/
