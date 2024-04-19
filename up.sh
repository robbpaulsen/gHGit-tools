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

# reset - commit your changes or stash them before you merge
# git reset --hard - personal alias - grh

# https://www.git-tower.com/learn/git/faq/undo-last-commit

# Revisar si hay nuevos cambios en el proyecto ya en GitHub
echo "Revisando si hay nuevos cambios en el sitio del proyecto"
git pull

workdir=$(pwd)

# Este comando va a respaldar todo lo que eeste el directorio raiz del proyecto
git add --all .

echo ""
echo ""
echo "####################################"
echo "#    Commits concisos y utiles     #"
echo "####################################"
echo ""
echo ""

read input

# Hacer un commit al repositorio local con un mensage conteniendo los detalles de los cambios o que se agrego

git commit -m "$input"

# Hacer push al repositorio en el sitio de GitHub

git push

echo "################################################################"
echo "##################  Finalizado el Git Push  ####################"
echo "################################################################"
