#!/bin/bash
#Checks if user $1 is created. If not, creates it with hashed password $2.
#Used flags : 2
#F2: user already exixts
#################
#Check if user already exists
	awk -F':' '{ print $1}' /etc/passwd | grep $1
	if [ $? = 0 ]
		then
			flag2=true
		else
			flag2=false
	fi
#Checks flags and creates if both false
	if [ $flag2 = true ]
		then
			if [ $3 = true ]
				then
					exit 0
				else
#Error 2: user already created and not allowed to use it
					exit 2
			fi
		else
			useradd -m  -r -N -p $2 -s /bin/bash $1
			if [ $? != 0 ]
				then
#Error 3 : Error in user creation
					exit 3
			fi
	fi
	exit $?
