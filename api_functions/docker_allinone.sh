#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################
##SCRIPT COMMAND USAGE : bash docker_main.sh {argument1} {argument2} {argument3} {argumentn}
#Arguments check
sudo apt-get update
sudo apt-get upgrade -y

user=$1
hash=$2
dimage=$3
soft=$4
group=$5
cname=$6
hport=$7
cport=$8

if [ -z $user ]
then user=docker
fi

if [ -z $dimage ]
then dimage=mongo
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

if [ -z $cname ]
then cname=mongodb
fi

if [ -z $hport ]
then hport=27017
fi

if [ -z $cport ]
then cport=27017
fi

##DEBUG ECHOs
echo "Chosen username is $user ."
echo "Hashed password is $hash ."
echo "Chosen docker image is $dimage ."

# Exit if the script was not launched by root
#if [ $USER != "root" ]
#then
#    sudo echo "The script needs to run as root" && exit 1
#fi
## Run the job that needs to be run as root
#For instance : command arguments
#bash docker_apt.sh sudo
apt list --installed $soft | grep $soft
if [ $? = 0 ]
  then
    flag1=true
  else
    flag1=false
fi
#Install package with apt
if  [ $flag1 != true ]
  then
   apt install $soft -y
fi
return $?


########################
flag3=false
#bash docker_createuser.sh $user $hash $flag3
awk -F':' '{ print $user}' /etc/passwd | grep $user
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
   useradd -m  -r -N -p $hash -s /bin/bash $user
    if [ $? != 0 ]
      then
        return 3
    fi
fi
return $?
##################
#bash docker_install.sh $user
apt purge docker docker-engine docker.io -y
apt update
apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add
apt-key fingerprint 0EBFCD88
apt update && apt install -y docker-ce
su $user -c "mkdir /home/$user/containers"

#bash docker_testinstall.sh
docker version
if [ $? -ne 0 ]
  then
    return 4
fi
docker run --name hello-world hello-world
if [ $? -ne 0 ]
  then
   docker ps -a
   docker stop hello-world && docker rm hello-world
    return 5
fi
  docker ps -a
  docker stop hello-world && docker rm hello-world
return $?

#bash docker_usermod.sh $user docker
groupadd $group
usermod -g $group $user
return $?
## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
#su docker -c "bash /opt/deploiement/docker_deployment.sh mongodb 27017 27017 $dimage"
su docker -c "mkdir /home/$user/containers/$cname"
su docker -c "docker run -d --name $cname -v /home/$user/containers/$cname:/data/db -p $hport:$cport $dimage"
su docker -c "docker ps"
