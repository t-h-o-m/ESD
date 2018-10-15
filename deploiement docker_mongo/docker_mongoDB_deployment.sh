#!/bin/bash

#Installing docker engine
sudo apt purge docker docker-engine docker.io -y 
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" 
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add 
sudo apt-key fingerprint 0EBFCD88 
sudo apt update && sudo apt install -y docker-ce

#Deploy MongoDB container
sudo docker run -d --name mongodb -p 27017:27017 mongo

