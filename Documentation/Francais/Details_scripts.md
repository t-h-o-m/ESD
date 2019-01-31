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
### `esd/master.sh`
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
	get_networkId.py ($applicationkey $applicationsecret $consumerkey $projectid)

## last_vlan.py
### `esd/last_vlan.py`
Récupération de l'id du dernier vlan créé pour éviter les doublons

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey $projectid)
	
## vlan_creation.py
###	`esd/vlan_creation.py`
Création d'un VLAN dans le projet OVH fourni

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH
- Nom de projet
- Nom de région
- Dernière VLAN créé

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey $projectid $project_name $region_id $last_vlan)


## create_instance.py
###	`esd/create_instance.py`
Création d'un machine virtuelle avec les options choisies et configure l'accès avec la clé SSH fournie

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH
- Nom de projet
- Nom de groupe
- Flavor ID
- Type de paiment
- Id d'image
- Id de région
- Id de VLAN
- IP locale
- Clé SSH

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey  $projectid $project_name1 None $flavor_id False $image_id $region_id $vlan_id 192.168.1.[4-6] $ssh_key)
	
## docker_allinone.sh
###	`esd/docker_allinone.sh`
Script lancé sur les machine pour installer docker et une base de donnée MongoDB

### Arguments demandés
- [Utilisateur cible]
- [Hash de mot de passe]
- [Image docker]
- [Paquet apt à installer]
- [Groupe utilisateur]
- [Nom de container]
- [Port exterieur]
- [Port container]

### Scripts parents
	master.sh
	
## check_credentials.py
###	`esd/script/check_credentials.py`
Vérification des identifiants de connexion et retour des projets OVH liés

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH

## get_region.py
###	`esd/script/get_region.py`
Récupration des régions disponible pour la création de machines virtuelles

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

## get_flavor.py
###	`esd/script/get_flavor.py`
Récupération des flavor disponibles

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH
- Id de région OVH

## get_sshkey.py
###	`esd/script/get_sshkey.py`
Récupération des clé ssh enregisté sur OVH

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

## get_networkId.py
###	`esd/script/get_networkId.py`
Récupréation d'une IP publique par OVH

### Arguments demandés
- Clé d'application OVH
- Secret d'application OVH
- Clé de client OVH
- Id de projet OVH

### Scripts parents
	master.sh ($applicationkey $applicationsecret $consumerkey $projectid)
