#!/bin/bash
set -e

WORKDIR="$(cd "$(dirname "$0")" && pwd)"

read -p "Introduce tu nombre para Git: " git_name
read -p "Introduce tu email para Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

sudo apt install -y i3
sudo apt install -y curl
sudo apt install -y xclip
sudo apt install -y ripgrep
sudo apt install -y wget
sudo apt install -y eza
sudo apt install -y build-essential
sudo apt install -y vim

#firacode fonts
sudo apt install -y fonts-firacode || true
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -f -v

#oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s

#gh-cli
(type -p wget >/dev/null || sudo apt install -y wget)

sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp)
wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg

sudo cp "$out" /etc/apt/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

sudo mkdir -p -m 755 /etc/apt/sources.list.d
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
  sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

sudo apt update
sudo apt install -y gh || true

#fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

#zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

#neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

#tema oscuro
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')
BASE="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE/"
# usar fuente personalizada
gsettings set $BASE use-system-font false
gsettings set $BASE font 'JetBrainsMono Nerd Font 12'
# ocultar scrollbar
gsettings set $BASE scrollbar-policy 'never'
# ocultar barra de menú
gsettings set org.gnome.Terminal.Legacy.Settings menu-accelerator-enabled false
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false

#dotfiles
cp -r "$WORKDIR"/dotfiles/nvim "$HOME"/.config/nvim
cp -r "$WORKDIR"/dotfiles/i3 "$HOME"/.config/i3
cp -r "$WORKDIR"/dotfiles/i3status "$HOME"/.config/i3status
cp -r "$WORKDIR"/dotfiles/oh-my-posh "$HOME"/.config/oh-my-posh
cp "$WORKDIR"/dotfiles/bashrc "$HOME"/.bashrc
cp "$WORKDIR"/dotfiles/vimrc "$HOME/.vimrc"
cp -r "$WORKDIR"/dotfiles/vim "$HOME/.vim"
