#!/bin/bash
#This file is the index of all functions for privileges allocaiton, docker engine installation and docker deployment on a debian 9 system
#################



# Exit if the script was not launched by root
if [ $USER != "root" ]
then
    echo "The script needs to run as root" && exit 1
fi
## Run the job that needs to be run as root
#For instance : command arguments

## Run the job(s) that don't need root
#For instance : su user -c "command arguments"
