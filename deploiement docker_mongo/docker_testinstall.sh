#!/bin/bash
#Run aftel install verification for docker
#################
	docker version
	if [$? != 0 ]
		then
#Error 4: Unable to recover docker version, install may have failed
			exit 4
	fi
	docker run hello-world
	if [$? != 0]
		then
#Error 5: Unable tu start container hello-world, connection to Docker Hub may have failed
			exit 5
	fi
	exit $?