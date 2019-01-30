## Script exemple.xx
###	`Chemin/du/script.xx`
Description du script

### Arguments demandés
- Argument obligatoire 
- [Argument optionel] 

### Scripts appelés
	Script.xx (argument donné)

### Scripts parents
	Script.xx (argument reçu)

## master.sh
### `agilitation/master.sh`
Script général s'occupant de la génération complète des machines virtuelles et des bases de données

### Arguments demandés
- Nom de projet
- Id de région
- Flavor ID de génération de machine
- Id d'image
- Clé SSH
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

### Scripts appelés
	last_vlan.py ($applicationkey $applicationsecret $consumerkey $projectid)
	vlan_creation.py ($applicationkey $applicationsecret $consumerkey $projectid $project_name $region_id $last_vlan)
	create_instance.py ($applicationkey $applicationsecret $consumerkey  $projectid $project_name1 None $flavor_id False $image_id $region_id $vlan_id 192.168.1.[4-6] $ssh_key)
	docker_allinone.sh

## last_vlan.py
### `agilitation/last_vlan.py`
Récupération de l'id du dernier vlan créé pour éviter les doublons

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey $projectid)
	
## vlan_creation.py
###	`agilitation/vlan_creation.py`
Création d'un VLAN dans le projet OVH fourni

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de clien OVH
- Id de projet OVH
- Nom de projet
- Nom de région
- Dernière VLAN créé

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey $projectid $project_name $region_id $last_vlan)