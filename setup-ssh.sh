#!/bin/bash
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
clear

export keyHome=~/.ssh

# funcion para obtener nombre para la llave a crear
get_key() {
	tput setaf 6
	read -p "Identificador de la llave a crear: " key
	tput sgr0
}

# funcion para obtener el password a asignar a la llave, usando el flag `-s`
# suprime la salida al stdout en la temrinal para que no sea visible
# lo que se escribe
get_secret() {
	tput setaf 6
	read -s -p "Introduce un password para tu nueva llave o deja vacio para no asignarle uno: " secret
	tput sgr0
}

# funcion para obtener el correo a unir a la llave
get_email() {
	tput setaf 6
	read -p "Introduce un correo para unirlo a tu llave: " EMAIL
	tput sgr0
}

echo ""
echo ""
get_key
echo ""
echo ""
get_secret
echo ""
echo ""
get_email
echo ""
echo ""

ssh-keygen -o -a 100 -t ed25519 -f "$keyHome"/"$key"_ed25519 -P "$secret" -C "$EMAIL"
eval "$(ssh-agent -s)"
ssh-add "$keyHome"/"$key"_ed25519

tput setaf 3
echo -e "\n\nAhora dirigete a tu cuenta y agrega la llave, este proceso \nno es posible hacerlo aun desde la terminal\n\n"
tput sgr0

chmod -x ./setup-ssh2.sh
