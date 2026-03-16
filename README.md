# Debian setup

Este proyecto permite instalar un entorno de `debian` orientado a desarrollo para uso en VM/hardware ligero.

Añade un entorno de escritorio i3 mucho mas ligero que el tradicional `gnome` o `kde` y una serie de herramientas para mejorar la experiencia de usuario y desarrollo.

## Requisitos

Necesitas una máquina virtual o un sistema cualquiera con Debian instalado.

Debes tener permisos de `sudo` para ejecutar los comandos de instalación, en debian puedes hacerlo asi:

```bash
su
/usr/sbin/usermod -aG sudo tu_usuario
```

> Tendrás que reiniciar para que los cambios surtan efecto.

## Instalación

Necesitarás tener `git` para clonar el repositorio:

```bash
sudo apt update
sudo apt install git
```

Una vez lo tengas, inicia el clonado y ejecuta el script de instalación:

```bash
git clone https://github.com/datadiego/debian-dotfiles.git
cd debian-dotfiles
chmod +x setup.sh
./setup.sh
```

El script se encargará de instalar todas las dependencias necesarias y configurar el entorno de escritorio i3, así como otras herramientas útiles.

## Tras la instalación

Una vez finalizada la instalación, reinicia tu sistema para que los cambios surtan efecto. Al iniciar sesión, deberías ver el nuevo entorno de escritorio i3.
