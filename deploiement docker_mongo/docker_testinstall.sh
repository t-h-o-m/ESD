#!/bin/bash
#Run aftel install verification for docker
#################
	docker version
	if [ $? -ne 0 ]
		then
#Error 4: Unable to recover docker version, install may have failed
			exit 4
	fi
	docker run --name hello-world hello-world
	if [ $? -ne 0 ]
		then
#Error 5: Unable tu start container hello-world, connection to Docker Hub may have failed
			docker ps -a
			docker stop hello-world && docker rm hello-world
			exit 5
	fi
		docker ps -a
		docker stop hello-world && docker rm hello-world
	exit $?
