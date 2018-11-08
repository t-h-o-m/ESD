#!/bin/bash


sudo python ./create_instance.py -pn MongoCloud1 -gid None -fid 9b312f04-e6ff-493f-bbd1-134510f49258 -mbill False -iid 07b741aa-3a50-45f4-8841-9692eea29428 -rid SBG5 --sshkey 63334e6f63325679646d5679 > resultat.json

instance_ip=`cat resultat.json`

sudo ssh -i /agilitation/id_rsa debian@$instance_ip 'sudo bash -s ' < docker_allinone.sh



