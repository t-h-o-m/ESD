#/bin/bash

#Lancement du script d'instanciation de VM 

python create_instance.py
#python ./create_instance.py -pn unautrenom -gid None -fid 9b312f04-e6ff-493f-bbd1-134510f49258 -mbill False -iid 07b741aa-3a50-45f4-8841-9692eea29428 -rid SBG5 --sshkey 63334e6f63325679646d5679 > resultat.txt

# Récupération de l'ip de la Vm créée 

$ip_instance = $(python get_instance_ip.py)

#Installation VM 

sudo ssh debian@$ip_instance 'bash -s arg1' < docker_allinone.sh



