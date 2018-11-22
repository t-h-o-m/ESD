#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################
##SCRIPT COMMAND USAGE : bash docker_main.sh {argument1} {argument2} {argument3} {argumentn}
#Arguments check
sudo apt-get update
sudo apt-get upgrade -y

user=$1
hash=$2
d_image=$3
soft=$4
group=$5
nomcontainer=$6
hport=$7
cport=$8

if [ -z $user ]
then user=docker
fi

if [ -z $d_image ]
then d_image=mongo
fi

if [ -z $hash ]
then hash=O.vrCmD1.nb9.
fi

if [ -z $soft ]
then soft=sudo
fi

if [ -z $group ]
then group=docker
fi

if [ -z $nomcontainer ]
then nomcontainer=mongodb
fi

if [ -z $hport ]
then hport=27017
fi

if [ -z $cport ]
then cport=27017
fi

##DEBUG ECHOs
sudo echo "Le nom d'utilisateur choisi est $user "
sudo echo "Le mot de passe (hashé) est $hash "
sudo echo "L'image docker $d_image est utilisé "

# Exit if the script was not launched by root
#if [ $USER != "root" ]
#then
#    sudo echo "The script needs to run as root" && exit 1
#fi
## Run the job that needs to be run as root
#For instance : command arguments
#bash docker_apt.sh sudo
sudo apt list --installed $soft | sudo grep $soft
if [ $? = 0 ]
  then
    flag1=true
  else
    flag1=false
fi
#Install package with apt
if  [ $flag1 != true ]
  then
   sudo apt install $soft -y
fi
return $?


########################
flag3=false
#bash docker_createuser.sh $user $hash $flag3
sudo awk -F':' '{ print $user}' /etc/passwd | sudo grep $user
if [ $? = 0 ]
  then
    flag2=true
  else
    flag2=false
fi
if [ $flag2 = true ]
  then
    if [ $flag3 = true ]
      then
        return 0
      else
        return 2
    fi
  else
   sudo useradd -m  -r -N -p $hash -s /bin/bash $user
    if [ $? != 0 ]
      then
        return 3
    fi
fi
return $?
##################
#bash docker_install.sh $user
sudo apt purge docker docker-engine docker.io -y
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add
sudo apt-key fingerprint 0EBFCD88
sudo apt update && sudo apt install -y docker-ce
su $user -c "mkdir /home/$user/containers"

#bash docker_testinstall.sh
sudo docker version
if [ $? -ne 0 ]
  then
    return 4
fi
sudo docker run --name hello-world hello-world
if [ $? -ne 0 ]
  then
   sudo docker ps -a
   sudo docker stop hello-world && sudo docker rm hello-world
    return 5
fi
  sudo docker ps -a
  sudo docker stop hello-world && sudo docker rm hello-world
return $?

#bash docker_usermod.sh $user docker
sudo groupadd $group
sudo usermod -g $group $user
return $?
## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
#su docker -c "bash /opt/deploiement/docker_deployment.sh mongodb 27017 27017 $d_image"
su docker -c "mkdir /home/$user/containers/$nomcontainer"
su docker -c "docker run -d --name $nomcontainer -v /home/docker/containers/$nomcontainer:/data/db -p $hport:$cport $d_image"
su docker -c "docker ps"
