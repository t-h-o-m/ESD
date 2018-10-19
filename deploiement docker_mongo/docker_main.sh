#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################
##SCRIPT COMMAND USAGE : bash docker_main.sh {argument1} {argument2} {argument3} {argumentn}
#Arguments check
$d_image=$1
if [ $d_image = "" ]
then $d_image=mongo
fi

# Exit if the script was not launched by root
if [ $USER != "root" ]
then
    echo "The script needs to run as root" && exit 1
fi
## Run the job that needs to be run as root
#For instance : command arguments
bash docker_apt.sh sudo
bash docker_createuser.sh docker
## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
su docker -c "bash docker_mongoDB_deployment.sh mongodb 27017 27017 $d_image"
