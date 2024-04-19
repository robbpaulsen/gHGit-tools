#!/usr/bin/env bash

#########################################################################################
##
## Author: robbpaulsen
## Github: https://github.com/robbpaulsen
##
#########################################################################################
##
## Configura de manera automatizada y mas rapida el repositorio para tu proyecto
## en github.com
##
#########################################################################################

read -p "Que nombre tendra tu proyecto?: " pname
read -p "Da una breve descripcion de tu proyecto para el README.md Inicial: " desc

gh repo create "$pname" --add-readme --description \
	"$desc" --public --clone && cd "$pname"/

chmod u+x ./git-setup.sh
