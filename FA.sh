#!/bin/bash


FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# URL del ZIP FA6 Free Desktop
FA6_URL="https://use.fontawesome.com/releases/v6.5.1/fontawesome-free-6.5.1-desktop.zip"

# Carpeta temporal
TMP_DIR=$(mktemp -d)

wget -qO "$TMP_DIR/fa6.zip" "$FA6_URL"

unzip -q "$TMP_DIR/fa6.zip" -d "$TMP_DIR"

# Copiar solo los OTF desde la carpeta correcta (FA6 Desktop tiene /otfs/ dentro de una subcarpeta)
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
