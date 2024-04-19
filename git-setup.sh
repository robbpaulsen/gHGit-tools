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

NORMAL='\033[0m'
YELLOW='\033[00;33m'
CYAN='\033[00;36m'
LRED='\033[01;31m'

purl=https://github.com
guser=robbpaulsen
project="$(basename $(pwd))"

echo -e "\n${YELLOW}[!]${NORMAL}${LRED} ESTE SCRIPT SOLO DEBE DE SER EJECUTADO UNA SOLA VEZ, AL FINAL DE SU EJECUCION \nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!${NORMAL}"

git config --global pull.rebase false
git config --global user.name "robbpaulsen"
git config --global user.email "pemmtest.087@gmail.com"
git config --system core.editor nvim
git config --global push.default simple
git remote set-url origin "$purl/$guser/$project"

echo -e "\n\n\t${CYAN}Ya todo esta configurado${NORMAL}\n\n\t"
sleep 2 &&
	chmod -x ./git-setup.sh

# Github Authentication with github-cli

#  gh auth login --with-token </path/to/token.txt
#  # yes you actually need to leave the "less than" symbol there
#  gh ssh-key add ~/.ssh/ authentication --title "your title" <key-file >--type
#  gh config set git_protocol ssh --host github.com
#  gh config set set prompt enable
#  gh config set editor nvim
#  gh config set pager glow
#  gh config set browser firefox
