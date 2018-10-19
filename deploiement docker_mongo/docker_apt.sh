#!/bin/bash
#Checks if package $1 is installed. If not, installs it.
#Used flags : 1
#F1: package already installed
#################
#Pre-install
	apt list --installed $1 | grep $1
	if [ $? = 0 ]
		then
			flag1 = true
	fi
#Install package with apt
	if  [ $flag1 != true ]
		then	
			apt install $1 -y
	fi
	exit $?