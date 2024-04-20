#!/usr/bin/env bash

#########################################################################################
##
## Author: robbpaulsen
## Github: https://github.com/robbpaulsen
##
#########################################################################################
##
## Configura de manera automatizada y mas rapido tu proyecto y concentrarte en lo que
## realmente importa, como nombres de variables, por que no compila y por que bash
## acaba de generar un directorio llamado "$HOME" en tu /home/$USER/
##
#########################################################################################

purl=https://github.com
project="$(basename $(pwd))"

tput setaf 3
echo -e "\n[!] ESTE SCRIPT SOLO DEBE DE SER EJECUTADO UNA SOLA VEZ, AL FINAL DE SU EJECUCION \nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!"
tput sgr0
sleep 2

get_user() {
	echo ""
	echo ""
	tput setaf 2
	read -p "Cual es tu Usuario?: " guser
	tput sgr0
	echo ""
	echo ""
}

get_email() {
	echo ""
	echo ""
	tput setaf 2
	read -p "Escribe un correo para la llave: " EMAIL
	tput sgr0
	echo ""
	echo ""
}

git config --global pull.rebase false
git config --global user.name "$guser"
git config --global user.email "$EMAIL"
git config --system core.editor nvim
git config --global push.default simple
git remote set-url origin "$purl"/"$guser"/"$project"

tput setaf 8
echo -e "\n\n\tYa todo esta configurado$\n\n\t"
tput sgr0
sleep 2 &&
	chmod -x ./git-setup.sh
