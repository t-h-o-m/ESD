#!/bin/bash
#Add user $1 to group $2
#################
	groupadd $2
	usermod -aG $2 $1
	su $1
	newgrp $2
	exit $?
