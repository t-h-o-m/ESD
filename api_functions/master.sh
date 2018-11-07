#/bin/bash

#Lancement du script d'instanciation de VM 

python create_instance.py

# Récupération de l'ip de la Vm créée 

$ip_instance = $(python get_instance_ip.py)

#Installation VM 

sudo ssh debian@$ip_instance 'bash -s arg1' < docker_allinone.sh



