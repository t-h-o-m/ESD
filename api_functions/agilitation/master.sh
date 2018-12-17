#!/bin/bash
#VARs declaration
project_name=$1
project_name1=$1_1
project_name2=$1_2
project_name3=$1_3
region_id=$2
flavor_id=$3
image_id=$4
ssh_key=$5
#Functions declaration
sshretry(){
	sudo ssh -v -o "StrictHostKeyChecking no" -i /agilitation/id_rsa debian@$1 'sudo bash -s ' < docker_allinone.sh
	return $?
}

#Creation du reseau prive

echo "Creation du reseau privé virtuel[...]"
sudo python vlan_creation.py -vn new_vlan -vr $region_id -vid 62 > resultat_vlan.json
vlan_id=`cat resultat_vlan.json`

#Creation de la premiere machine virtuelle 

echo "Initialisation de la machine virtuelle [...]"
sudo python ./create_instance.py -pn $project_name1 -gid None -fid $flavor_id -mbill False -iid $image_id -rid $region_id -vid $vlan_id -lip 192.168.1.4 --sshkey $ssh_key > resultat.json
instance_ip=`cat resultat.json`
echo "Connexion a la machine virtuelle 1 et deploiement de l'environnement MongoDB"

sshretry $instance_ip
while [ $? -ne 0 ]; do
	sleep 10
       	sshretry $instance_ip
done

#Creation de la deuxieme machine virtuelle

sudo python ./create_instance.py -pn $project_name2 -gid None -fid $flavor_id -mbill False -iid $image_id -rid $region_id -vid $vlan_id -lip 192.168.1.5 --sshkey $ssh_key > resultat2.json
instance_ip2=`cat resultat2.json`
echo "Connexion a la machine virtuelle 2 et deploiement de l'environnement MongoDB"

sshretry $instance_ip2
while [ $? -ne 0 ]; do
	sleep 10
       	sshretry $instance_ip2
done


#Creation de la troisieme machien virtuelle

sudo python ./create_instance.py -pn $project_name3 -gid None -fid $flavor_id -mbill False -iid $image_id -rid $region_id -vid $vlan_id -lip 192.168.1.6 --sshkey $ssh_key > resultat3.json
instance_ip3=`cat resultat3.json`
echo "Connexion a la machine virtuelle 3 et deploiement de l'environnement MongoDB"

sshretry $instance_ip3
while [ $? -ne 0 ]; do
	sleep 10
       	sshretry $instance_ip3
done


echo "Environnement MongoDB deploye avec succes"
echo "Adresse ip des machines creees :"
cat resultat.json
cat resultat2.json
cat resultat3.json

#Deploiement du replicaSet mondoDB
sleep 10;
mongo --host $instance_ip --port 27017 --eval 'rs.initiate({_id:"agilitation",version:1,members:[{_id:0,host:"192.168.1.4:27017"},{_id:1,host:"192.168.1.5:27017"},{_id:2,host:"192.168.1.6:27017"}]})'
