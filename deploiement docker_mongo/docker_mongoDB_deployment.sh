#!/bin/bash

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
#The test container is running mongodb, is called mongodb and is actually doing NAT from p27017 to p27017 on host
sudo docker run -d --name mongodb -p 27017:27017 mongo
