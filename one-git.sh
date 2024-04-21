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
trap ctrl_c INT

function ctrl_c() {
	exit_script
}

function exit_script() {
	echo -e "${sign_good} Exiting script"
	tput cnorm
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
	echo -e "\n\n${sign_good} \n\nAhora dirigete a tu cuenta y agrega la llave, este proceso \nno es posible hacerlo aun desde la terminal\n\n"
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
	echo ""
	echo -e "\n${YELLOW}[!]${NORMAL}${LRED} ESTE SCRIPT SOLO DEBE DE SER USADO UNA SOLA VEZ, AL FINAL\nDEJARA DE SER EJECUTABLE PARA PREVENIR ACCIDEDNTES!${NORMAL}"
	get_project
	git init
	git config --global pull.rebase false
	get_user
	echo ""
	echo ""
	git config --global user.name "$guser"
	get_email
	git config --global user.email "$EMAIL"
	git config --system core.editor nvim
	git config --global push.default simple
	git remote set-url origin "$purl/$guser/$project"
	git add .
	echo ""
	echo ""
	get_commit
	git push -u
	tput setaf 6
	echo -e "\n\n\tYa todo esta configurado y se hizo el primer push\n\n\t"
	echo ""
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
	echo -e "\n\n${sign_info} Se va a agregar al stage todas las modificaciones\n\n"
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
	echo -e "\n\n${sign_info} Se Actualizara el proyecto en el sitio con \nlos nuevos cambios\n\n"
	${nc}
	git pull
	git push -u
}

add_commit_push() {
	${green}
	echo -e "\n\n${sign_info} Se Actualizara el proyecto en el sitio con \nlos nuevos cambios\n\n"
	${nc}
	git pull
	add_files
	get_commit
	git push
}

menu() {
	clear
	while true; do
		echo ""
		echo ""
		tput setaf 6
		echo -e "\n1 [+] Generar una nueva llave SSH  para tu proyecto\n"
		echo ""
		echo ""
		echo -e "\n2 [+] Generar Repositorio en Remoto, no en local\n"
		echo ""
		echo ""
		echo -e "\n3 [+] Generar de tu proyecto local un repositorio en tu remoto GitHub\n"
		echo ""
		echo ""
		echo -e "\n4 [+] Sincronizarse con remoto unicamente\n"
		echo ""
		echo ""
		echo -e "\n5 [+] Agregar los cambios recien hechos\n"
		echo ""
		echo ""
		echo -e "\n6 [+] Hacer un Commit\n"
		echo ""
		echo ""
		echo -e "\n7 [+] Hacer push Simple\n"
		echo ""
		echo ""
		echo -e "\n8 [+] Hacer un add, commit y Push\n"
		tput sgr 0
		tput setaf 1
		echo -e "\n9 [!] Salir\n"
		echo ""
		echo ""
		tput sgr 0
		echo ""
		echo ""
		tput setaf 3
		read -p "Elige la opcion deseada: " numero
		tput sgr 0
		echo ""
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
			echo -e "\n[!] La opcion deseada no existe, intentar de nuevo [!]\n"
			tput sgr 0
			;;
		esac
	done
}
menu
