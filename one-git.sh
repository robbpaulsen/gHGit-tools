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

# Variables

## Paths
export keyHome=~/.ssh

## Colors
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 8)"
purple="$(tput setaf 5)"
cyan="$(tput setaf 6)"
grey="$(tput setaf 7)"
nc="$(tput sgr0)"

## Signs
sign_wrong="${red}[-]${nc}"
sign_good="${green}[+]${nc}"
sign_warn="${yellow}[!]${nc}"
sign_info="${blue}[i]${nc}"
sign_ask="${purple}[?]${nc}"
sign_doing="${cyan}[~]${nc}"
sign_cmd="${grey}[>]${nc}"

## Script Variables
purl=https://github.com
guser=robbpaulsen
project="$(basename $(pwd))"

# Functions
trap ctrl_c INT

function ctrl_c() {
	exit_script
}

function exit_script() {
	echo -e "${sign_good} Exiting script"
	tput cnorm
	exit 0
}

get_key() {
	tput setaf 6
	read -p "Identificador de la llave a crear: " key
	tput sgr0
}

get_secret() {
	tput setaf 6
	read -s -p "Introduce un password para tu nueva llave o deja vacio para no asignarle uno: " secret
	tput sgr0
}

get_email() {
	tput setaf 6
	read -p "Introduce un correo para unirlo a tu llave: " EMAIL
	tput sgr0
}

get_ssh_key() {
	ssh-keygen -o -a 100 -t ed25519 -f "$keyHome"/"$key"_ed25519 \
		-P "$secret" -C "$EMAIL"
	eval "$(ssh-agent -s)"
	ssh-add "$keyHome"/"$key"_ed25519
	${green}
	echo -e "\n\n${sign_good} \n\nAhora dirigete a tu cuenta y agrega la llave, este proceso \nno es posible hacerlo aun desde la terminal\n\n"
	${nc}
}

get_project() {
	${grey}
	read -p "Asignale un nombre a tu repositorio: " pname
	${nc}
}

get_description() {
	${grey}
	read -p "Da una breve descripcion de tu proyecto para el README.md Inicial: " desc
	${nc}
}

create_repo() {
	echo ""
	echo ""
	get_project
	echo ""
	echo ""
	get_description
	echo ""
	echo ""
	gh repo create "$pname" --add-readme --description "$desc" \
		--public --clone
}

git_pull() {
	${green}
	echo "Revisando si hay nuevos cambios en el sitio del proyecto"
	${nc}
	git pull
}

add_files() {
	${yellow}
	echo -e "\n\n${sign_info} Se va a agregar al stage todas las modificaciones\n\n"
	${nc}
	git add --all .
}

commit_message() {
	${cyan}
	read -p "Escribe una breve descripcion de los cambios realizados o agregados: " input
	${nc}
	git commit -m "$input"
}

push_2repo() {
	${green}
	echo -e "\n\n${sign_info} Se Actualizara el proyecto en el sitio con \nlos nuevos cambios\n\n"
	${nc}
	git push -u
}
