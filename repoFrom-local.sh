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
CYAN='\033[00;36m'
LRED='\033[01;31m'

purl=https://github.com
guser=robbpaulsen
gemail=pemmtest.087@gmail.com
project="$(basename $(pwd))"

echo -e "\n${YELLOW}[!]${NORMAL}${LRED} ESTE SCRIPT SOLO DEBE DE SER USADO UNA SOLA VEZ, AL FINAL\nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!${NORMAL}"
git init
git add .
git config --global pull.rebase false
git config --global user.name "$guser"
git config --global user.email "$gemail"
git config --system core.editor nvim
git config --global push.default simple
git remote set-url origin "$purl/$guser/$project"

read -p "Escribe el mensaje para tu commit: " kommit
git commit -m "$kommit"
git push -u

echo -e "\n\n\t${CYAN}Ya todo esta configurado y se hizo el primer push${NORMAL}\n\n\t"
sleep 2 &&
	chmod -x ./repoFrom-local.sh
