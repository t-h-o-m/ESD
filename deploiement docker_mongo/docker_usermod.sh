#!/bin/bash
#Add user $1 to group $2
#################
	usermod -aG  $1 $2
	exit $?