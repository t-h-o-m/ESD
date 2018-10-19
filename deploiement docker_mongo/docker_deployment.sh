#!/bin/bash
#Command Usage : ./docker_mongoDB_deployment.sh {containername} {HOSTport} {CONTAINERport} {dockerimage}
###############################################################################################


##MONGODB CONTAINER DEPLOYMENT
sudo mkdir /home/docker/containers/$1
sudo docker run -d --name $1 -v /home/docker/containers/$1:/data/db -p $2:$3 $4
