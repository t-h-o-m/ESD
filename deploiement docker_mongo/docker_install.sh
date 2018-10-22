#!/bin/bash
#Command Usage : ./docker_install.sh {USER}
###############################################################################################

##INSTALLATION DOCKER-ENGINE
#Purge of older versions of softwares
apt purge docker docker-engine docker.io -y
#System Update & dependencies installation
apt update
apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
#Docker repository addition to system's repositories
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add
apt-key fingerprint 0EBFCD88
#System update & docker engine installation.
apt update &&  apt install -y docker-ce

##Container directory creation
su $1 -c "mkdir /home/$1/containers"
