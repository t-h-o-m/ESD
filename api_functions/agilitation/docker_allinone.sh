#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################
##SCRIPT COMMAND USAGE : bash docker_main.sh {argument1} {argument2} {argument3} {argumentn}
#Arguments check

user=$1
hash=$2
dimage=$3
soft=$4
group=$5
cname=$6
hport=$7
cport=$8

#Check if var is empty then default value
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
#echo "Chosen username is $user ."
#echo "Hashed password is $hash ."
#echo "Chosen docker image is $dimage ."

# Exit if the script was not launched by root
#if [ $USER != "root" ]
#then
#   echo "The script needs to run as root" && exit 1
#fi
## Run the job that needs to be run as root
#For instance : command arguments
#Installation of sudo if not already there
function docker_apt {
	apt list --installed $1 | grep $1
	if [ $? = 0 ]
	  then
		flag1=true
	  else
		flag1=false
	fi
	#Install package with apt
	if  [ $flag1 != true ]
	  then
	   apt install $1 -y
	fi
	return $?
}
docker_apt $soft

########################
flag3=false
#creation of docker user
function docker_createuser {
	awk -F':' '{ print $user}' /etc/passwd | grep $user
	if [ $? = 0 ]
	  then
		flag2=true
	  else
		flag2=false
	fi
	if [ $flag2 = true ]
	  then
		if [ $3 = true ]
		  then
			return 0
		  else
			return 2
		fi
	  else
	   useradd -m  -r -N -p $2 -s /bin/bash $1
		if [ $? != 0 ]
		  then
			return 3
		fi
	fi
return $?
}
docker_createuser $user $hash $flag3
##################
#Installation of Docker Community Edition for latest Debian 9.x
function docker_install {
	apt purge docker docker-engine docker.io -y
	apt update
	apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add
	apt-key fingerprint 0EBFCD88
	apt update && apt install -y docker-ce
	su $1 -c "mkdir /home/$user/containers"
}
docker_install $user
#verify docker is installed
function docker_testinstall {
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
}
docker_testinstall

#give permissions to docker user to use docker
function docker_usermod {
	groupadd $2
	usermod -g $2 $1
	return $?
}
docker_usermod $user $group

## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
#Creation of folders for sharing config and data from and to container
su docker -c "mkdir -p /home/$user/containers/full_image/$cname"
su docker -c "mkdir -p /home/$user/containers/configs/$cname"
chown -R docker:docker /home/$user/*
#Initialization of config file
su docker -c "echo \"replSet=agilitation\"> /home/$user/containers/configs/$cname/mongod.conf"
#DEBUG
echo /home/$user/containers/configs/$cname/mongod.conf
#Container initialization
su docker -c "docker run -d --name $cname -v /home/$user/containers/configs/$cname:/etc/mongo -v /home/$user/containers/full_image/$cname:/data/db -p $hport:$cport $dimage --config /etc/mongo/mongod.conf"
#Check if container has started
su docker -c "docker ps"
