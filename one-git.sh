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
sign_good="${green}[+]${nc}"
sign_info="${blue}[i]${nc}"

## Script Variables
purl=https://github.com
project="$(basename $(pwd))"

# Functions

ctrl_c() {
	tput setaf 3
	echo "Saliendo ..."
	tput sgr 0
	exit
}
trap ctrl_c INT

exit_script() {
	clear
	echo ""
	tput setaf 3
	echo -e "${sign_good} Exiting script"
	tput sgr 0
	exit 0
}

###################################################################################################
##
## Generar una nueva llave SSH  para tu proyecto
##
###################################################################################################

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
	echo -e "\n\t${sign_good} Ahora dirigete a tu cuenta y agrega la llave, este proceso no es posible \nhacerlo aun desde la terminal."
	${nc}
}

###################################################################################################
##
## Generar Repositorio en Remoto, no en local
##
###################################################################################################

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
	get_project
	get_description
	echo ""
	gh repo create "$pname" --add-readme --description "$desc" \
		--public --clone
}

###################################################################################################
##
## Generar de tu proyecto local un repositorio en tu remoto GitHub
##
###################################################################################################

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

fromLocal_2Remote() {
	clear
	echo ""
	echo -e "\n${YELLOW}[!]${NORMAL}${LRED} ESTE SCRIPT SOLO DEBE DE SER USADO UNA SOLA VEZ, AL FINAL\nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!${NORMAL}"
	echo ""
	get_project
	git init
	git config --global pull.rebase false
	get_user
	git config --global user.name "$guser"
	get_email
	git config --global user.email "$EMAIL"
	git config --system core.editor nvim
	git config --global push.default simple
	git remote set-url origin "$purl/$guser/$project"
	git add .
	get_commit
	git push -u
	tput setaf 6
	echo -e "\n\tYa todo esta configurado y se hizo el primer push\n"
	echo ""
	tput sgr 0
}

###################################################################################################
##
## Sincronizarse con remoto unicamente
##
###################################################################################################

git_pull() {
	${green}
	echo "Revisando si hay nuevos cambios en el sitio del proyecto"
	${nc}
	git pull
}

###################################################################################################
##
## Agregar los cambios recien hechos
##
###################################################################################################

add_files() {
	${yellow}
	echo -e "\n${sign_info} Agregaran al stage todas las modificaciones\n"
	${nc}
	git add .
}

###################################################################################################
##
## Si ya estas listo para enviar tus cambios hecho al stack escribe una breve descripcion
##
###################################################################################################

get_commit() {
	${cyan}
	read -p "Escribe una breve descripcion de los cambios realizados o agregados: " kommit
	${nc}
	git commit -m "$kommit"
}

###################################################################################################
##
## Hacer Push de tu proyecto local a remoto en GitHub
##
###################################################################################################

just_push() {
	${green}
	echo -e "\n${sign_info} Se Actualizara el proyecto en el sitio con \nlos nuevos cambios."
	${nc}
	git push
}

add_commit_push() {
	${green}
	echo -e "\n${sign_info} Se Actualizara el proyecto en el sitio con \nlos nuevos cambios."
	${nc}
	git pull
	add_files
	get_commit
	just_push
}

menu() {
	clear
	while true; do
		clear
		echo ""
		tput setaf 3
		echo -e "\n\t$1 1 [+] Generar una nueva llave SSH  para tu proyecto."
		echo ""
		echo -e "\n\t$2 2 [+] Generar Repositorio en Remoto, no en local."
		echo ""
		echo -e "\n\t$3 3 [+] Generar de tu proyecto local un repositorio en tu remoto GitHub."
		echo ""
		echo -e "\n\t$4 4 [+] Sincronizarse con remoto unicamente."
		echo ""
		echo -e "\n\t$5 5 [+] Agregar los cambios recien hechos."
		echo ""
		echo -e "\n\t$6 6 [+] Hacer un Commit."
		echo ""
		echo -e "\n\t$7 7 [+] Hacer push Simple."
		echo ""
		echo -e "\n\t$8 8 [+] Hacer un add, commit y Push."
		tput sgr 0
		echo ""
		tput setaf 1
		echo -e "\n\t$9 9 [!] Salir\n"
		echo ""
		tput sgr 0
		echo ""
		tput setaf 8
		read -p "Elige la opcion deseada: " numero
		tput sgr 0
		echo ""
		case $numero in
		1)
			get_ssh_key
			;;
		2)
			create_repo
			;;
		3)
			fromLocal_2Remote
			;;
		4)
			git_pull
			;;
		5)
			add_files
			;;
		6)
			get_commit
			;;
		7)
			just_push
			;;
		8)
			add_commit_push
			;;
		9)
			exit_script
			;;
		*)
			tput setaf 1
			echo -e "\n\t[!] La opcion deseada no existe, intentar de nuevo [!]"
			tput sgr 0
			;;
		esac
	done
}
menu
