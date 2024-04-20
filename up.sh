#!/bin/bash
#set -e
##################################################################################################################
# Author    : Robbpaulsen
# Website   : https://www.erikdubois.be
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

clear

# reset - commit your changes or stash them before you merge
# git reset --hard - personal alias - grh
# https://www.git-tower.com/learn/git/faq/undo-last-commit

# Revisar si hay nuevos cambios en el proyecto ya en GitHub
tput setaf 2
echo "Revisando si hay nuevos cambios en el sitio del proyecto"
tput sgr0
git pull

# Este comando va a respaldar todo lo que eeste el directorio raiz del proyecto
git add --all .

echo ""
echo ""
tput setaf 3
echo "####################################"
echo "#    Commits concisos y utiles     #"
echo "####################################"
tput sgr0
echo ""
echo ""

read -p "Escribe una breve descripcion de los cambios realizados o agregados: " input

# Hacer un commit al repositorio local con un mensage conteniendo los detalles de los cambios o que se agrego

git commit -m "$input"

# Hacer push al repositorio en el sitio de GitHub

git push

tput setaf 3
echo "################################################################"
echo "##################  Finalizado el Git Push  ####################"
echo "################################################################"
tput sgr0
