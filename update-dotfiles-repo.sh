#!/bin/bash

echo "Este script sustituirá los dotfiles en el repositorio con los de tu sistema. ¿Deseas continuar? (s/n)"
read -r respuesta
if [[ "$respuesta" != "s" ]]; then
    echo "Operación cancelada."
    exit 0
fi

echo "Actualizando dotfile de Alacritty en repositorio..."
cp ~/.config/alacritty/alacritty.toml ./dotfiles/alacritty.toml
echo "Actualizando dotfile de Polybar en repositorio..."
cp ~/.config/polybar/config.ini ./dotfiles/polybar-config.ini
echo "Actualizando dotfile de Bash en repositorio..."
cp ~/.bashrc ./dotfiles/bashrc
echo "Actualizando dotfile de Oh My Posh en repositorio..."
cp ~/.config/oh-my-posh/dracula.omp.json ./dotfiles/dracula.omp.json
echo "Actualizando configuración de VS Code en repositorio..."
cp ~/.config/Code/User/settings.json ./dotfiles/code.settings.json
echo "Actualizando dotfile de BSPWM en repositorio..."
cp ~/.config/bspwm/bspwmrc ./dotfiles/bspwmrc
echo "Actualizando dotfile de SXHKD en repositorio..."
cp ~/.config/sxhkd/sxhkdrc ./dotfiles/sxhkdrc
echo "Actualizando dotfile de Picom en repositorio..."
cp ~/.config/picom/picom.conf ./dotfiles/picom.conf

echo "¡Dotfiles actualizados en el repositorio!"

