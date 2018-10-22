#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################
##SCRIPT COMMAND USAGE : bash docker_main.sh {argument1} {argument2} {argument3} {argumentn}
#Arguments check
user=$1
hash=$2
d_image=$3

if [ -z $user ]
then user=docker
fi

if [ -z $d_image ]
then d_image=mongo
fi

if [ -z $hash ]
then hash=O.vrCmD1.nb9.
fi
##DEBUG ECHOs
echo "Le nom d'utilisateur choisi est $user "
echo "Le mot de passe (hashé) est $hash "
echo "L'image docker $d_image est utilisé "

# Exit if the script was not launched by root
if [ $USER != "root" ]
then
    echo "The script needs to run as root" && exit 1
fi
## Run the job that needs to be run as root
#For instance : command arguments
bash docker_apt.sh sudo
flag3=false
bash docker_createuser.sh $user $hash $flag3
bash docker_install.sh $user
bash docker_testinstall.sh
bash docker_usermod.sh $user docker

## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
su docker -c "bash /opt/deploiement/docker_deployment.sh mongodb 27017 27017 $d_image"
##Root is exited at the end of the script
su docker
