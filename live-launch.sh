#!/bin/bash
# Si estás en un live-usb, lanza este script, pulsa CTRL+ALT+F3, inicia sesión y luego ejecuta startx
echo "exec i3" ~/.xinitrc
touch ~/.Xauthority
sudo apt install xorg xserver-xorg coreutils

#Alternativamente, instala lightdm
#Luego lanza
#sudo systemctl disable --now gdm-autologin
#sudo systemctl disable --now gdm-launch-environment
#sudo systemctl enable lightdm
#sudo systemctl start lightdm
