#!/bin/bash

echo "Initialisation de la machine virtuelle [...]"
sudo python ./create_instance.py -pn Mongocloud -gid None -fid 9b312f04-e6ff-493f-bbd1-134510f49258 -mbill False -iid d60f629d-7f22-4db8-9f4a-cf480a26856f -rid SBG5 --sshkey 63334e6f63325679646d5679 > resultat.json

instance_ip=`cat resultat.json`

echo "Connexion a la machine virtuelle et deploiement de l'environnement MongoDB"
sudo ssh -i /agilitation/id_rsa debian@$instance_ip 'sudo bash -s ' < docker_allinone.sh
echo "Environnement MongoDB deploye avec succes"
echo "Adresse ip de la machine creee :"
cat resultat.json

