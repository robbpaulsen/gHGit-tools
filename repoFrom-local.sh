#!/usr/bin/env bash

#########################################################################################
##
## Author: robbpaulsen
## Github: https://github.com/robbpaulsen
##
#########################################################################################
##
## Este script solo se debe de usar en el caso de que ya tengas un direcotrio local
## inicializado con git, ya hayas hecho lo que consideras como tu codigo estable y/o
## estes satisfecho con lo que tienes para tu proyecto. ES TOTALMENTE DIFERENTE AL SCRIPT
## `git-setup.sh`
##
#########################################################################################

NORMAL='\033[0m'
YELLOW='\033[00;33m'
LRED='\033[01;31m'

purl=https://github.com
project="$(basename $(pwd))"

get_email() {
	tput setaf 7
	read -p "Introduce un correo para unirlo a tu llave: " EMAIL
	tput sgr0
}

get_user() {
	tput setaf 7
	read -p "Cual e stu Usuario?: " guser
	tput sgr0
}

get_commit() {
	tput setaf 7
	read -p "Escribe el mensaje para tu commit: " kommit
	tput sgr 0
}

main() {
	echo -e "\n${YELLOW}[!]${NORMAL}${LRED} ESTE SCRIPT SOLO DEBE DE SER USADO UNA SOLA VEZ, AL FINAL\nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!${NORMAL}"
	git init
	get_user
	get_email
	git config --global pull.rebase false
	git config --global user.name "$guser"
	git config --global user.email "$EMAIL"
	git config --system core.editor nvim
	git config --global push.default simple
	git remote set-url origin "$purl/$guser/$project"
	git add .
	get_commit
	git push -u
	tput setaf 6
	echo -e "\n\n\tYa todo esta configurado y se hizo el primer push\n\n\t"
	tput sgr 0
	sleep 2 &&
		chmod -x ./repoFrom-local.sh
}

main
