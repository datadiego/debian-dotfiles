#!/bin/bash
# Script para configurar Wi-Fi Broadcom BCM43224 en MacBook Air 2012
# Compatible con Debian 13 (Trixie) fresh install

set -e

cat <<EOF >/etc/apt/sources.list
deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
EOF

apt update

apt install -y build-essential dkms linux-headers-$(uname -r)

apt install -y broadcom-sta-dkms

dkms remove -m broadcom-sta -v 6.30.223.271 --all || true
dkms install -m broadcom-sta -v 6.30.223.271

modprobe -r b43 brcmsmac bcma || true

modprobe wl
