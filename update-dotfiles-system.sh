#!/bin/bash

echo "Este script sustituirá los dotfiles en tu sistema con los del repositorio. ¿Deseas continuar? (s/n)"
read -r respuesta
if [[ "$respuesta" != "s" ]]; then
    echo "Operación cancelada."
    exit 0
fi

echo "Actualizando dotfile de Alacritty en sistema..."
cp ./dotfiles/alacritty.toml ~/.config/alacritty/alacritty.toml
echo "Actualizando dotfile de Polybar en sistema..."
cp ./dotfiles/polybar-config.ini ~/.config/polybar/config.ini
echo "Actualizando dotfile de Bash en sistema..."
cp ./dotfiles/bashrc ~/.bashrc
echo "Actualizando dotfile de Oh My Posh en sistema..."
cp ./dotfiles/dracula.omp.json ~/.config/oh-my-posh/dracula.omp.json
echo "Actualizando configuración de VS Code en sistema..."
cp ./dotfiles/code.settings.json ~/.config/Code/User/settings.json
echo "Actualizando dotfile de BSPWM en sistema..."
cp ./dotfiles/bspwmrc ~/.config/bspwm/bspwmrc
echo "Actualizando dotfile de SXHKD en sistema..."
cp ./dotfiles/sxhkdrc ~/.config/sxhkd/sxhkdrc
echo "Actualizando dotfile de Picom en sistema..."
cp ./dotfiles/picom.conf ~/.config/picom/picom.conf

#recargar bashrc,polybar,bspwm y sxhkd
source ~/.bashrc
polybar-msg cmd restart
bspc wm -r
pkill -USR1 -x sxhkd

echo "¡Dotfiles actualizados en el sistema!"
