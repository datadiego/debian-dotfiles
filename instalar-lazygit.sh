#!/bin/bash
set -e

URL="https://github.com/jesseduffield/lazygit/releases/download/v0.56.0/lazygit_0.56.0_linux_x86_64.tar.gz"

echo "Descargando LazyGit..."
wget -O lazygit.tar.gz "$URL"

echo "Descomprimiendo..."
tar -xzf lazygit.tar.gz

echo "Instalando en /usr/local/bin..."
sudo install lazygit /usr/local/bin/

echo "Limpiando archivos temporales..."
rm lazygit lazygit.tar.gz

echo "Instalación completa. Ejecuta: lazygit"
