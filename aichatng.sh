#!/usr/bin/env bash
set -e

curl https://sh.rustup.rs -sSf | sh -s -- -y

# Añadir cargo al PATH en la sesión actual
export PATH="$HOME/.cargo/bin:$PATH"

# Añadir al .bashrc para futuras sesiones
# esto sobra si lo tenemos en bashrc ya
grep -qxF 'export PATH="$HOME/.cargo/bin:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc
cargo --version

# Clonar repo
TMPDIR=$(mktemp -d)
git clone https://github.com/blob42/aichat-ng.git "$TMPDIR/aichat-ng"
cd "$TMPDIR/aichat-ng"

# Instalar usando cargo desde la ruta local
cargo install --path .

aichatng --version || echo "AIChat-NG instalado, verifica ejecutando: aichatng"

cd ~
rm -rf "$TMPDIR"