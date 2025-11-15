sudo apt install fonts-firacode
# O instalar a mano:
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts
fc-cache -fv

curl -s https://ohmyposh.dev/install.sh | bash -s
