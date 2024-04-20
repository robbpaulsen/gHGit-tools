#!/usr/bin/env bash
## set -e
##################################################################################################################
## Author    : robbpaulsen
## Website   : https://www.github.com
##################################################################################################################
## tput setaf 0 = black
## tput setaf 1 = red
## tput setaf 2 = green
## tput setaf 3 = yellow
## tput setaf 4 = dark blue
## tput setaf 5 = purple
## tput setaf 6 = cyan
## tput setaf 7 = gray
## tput setaf 8 = light blue
##################################################################################################################

export keyHome=~/.ssh

echo ""
echo ""
tput setaf 6
read -p "Identificador de la llave a crear: " key
tput sgr0
echo ""
echo ""
tput setaf 6
read -s -p "Asigna un passowrd a la llave o deja vacio: " secret
tput sgr0
echo ""
echo ""
tput setaf 6
read -p "Ingresa un correo para unir a la llave: " EMAIL
tput sgr0
echo ""
echo ""

ssh-keygen -o -a 100 -t ed25519 -f "$keyHome"/"$key"_ed25519 -P "$secret" -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add "$keyHome"/"$key"_ed25519

tput setaf 3
echo -e "\nAhora dirigete a tu cuenta y agrega la llave, este proceso \nno es posible hacerlo aun desde la terminal"
tput sgr0

chmod -x ./setup-ssh2.sh
