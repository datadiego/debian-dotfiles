#!/bin/bash

# Script para redimensionar ventanas en bspwm de forma intuitiva
# Similar a i3/Hyprland

direction=$1
size=${2:-20}

case $direction in
    left)
        # Intentar expandir a la izquierda, si no funciona contraer desde la derecha
        bspc node -z left -$size 0 || bspc node -z right -$size 0
        ;;
    down)
        # Intentar expandir hacia abajo, si no funciona contraer desde arriba
        bspc node -z bottom 0 $size || bspc node -z top 0 $size
        ;;
    up)
        # Intentar expandir hacia arriba, si no funciona contraer desde abajo
        bspc node -z top 0 -$size || bspc node -z bottom 0 -$size
        ;;
    right)
        # Intentar expandir a la derecha, si no funciona contraer desde la izquierda
        bspc node -z right $size 0 || bspc node -z left $size 0
        ;;
esac
