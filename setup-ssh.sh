#!/bin/bash
#set -e
##################################################################################################################
# Author    : robbpaulsen
# Website   : https://www.github.com
##################################################################################################################
#
#
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

export keyHome=~/.ssh

read -p "Identificador de la llave a crear: " key

ssh-keygen -o -a 100 -t ed25519 -f "$keyHome"/"$key"_ed25519 -C "pemmtest.087@gmail.com"

eval "$(ssh-agent -s)"

ssh-add $keyHome/"$key"_ed25519

echo -e "\nAhora dirigete a tu cuenta y agrega la llave, este proceso \nno es posible hacerlo aun desde la terminal"

chmod -x ./ssh.sh
