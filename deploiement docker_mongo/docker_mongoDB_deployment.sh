#!/bin/bash
#Command Usage : ./docker_mongoDB_deployment.sh {containername} {HOSTport} {CONTAINERport} {dockerimage}
###############################################################################################

##INSTALLATION DOCKER-ENGINE
#Purge of older versions of softwares
sudo apt purge docker docker-engine docker.io -y
#System Update & dependencies installation
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
#Docker repository addition to system's repositories
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add
sudo apt-key fingerprint 0EBFCD88
#System update & docker engine installation.
sudo apt update && sudo apt install -y docker-ce

##MONGODB CONTAINER DEPLOYMENT
# Testing commands under that sentence are commented when not used
# sudo mkdir /home/docker
sudo mkdir /home/docker/containers
sudo mkdir /home/docker/containers/$1
sudo docker run -d --name $1 -v /home/docker/containers/$1:/data/db -p $2:$3 $4
