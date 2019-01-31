# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''

import json
import ovh
import sys
import argparse
import time 

# Creation of Script options
# This will help the user to understand Agilitation's Script
# by typing 'python3 scriptname.py -h'

parser = argparse.ArgumentParser()
parser.add_argument("-ak", "--applicationkey", help="enter your application key")
parser.add_argument("-as", "--applicationsecret", help="enter your application secret")
parser.add_argument("-ck", "--consumerkey", help="enter your consumer key")
parser.add_argument("-pid", "--projectid", help="enter your project id (cloud)")
parser.add_argument("-pn", "--projectname", help="choose your project name")
parser.add_argument("-gid", "--groupid", help="choose which groupid you want to be in, if none type None")
parser.add_argument("-fid", "--flavorid", help="choose which flavorId you want for your VM")
parser.add_argument("-mbill", "--monthlybilling", choices=["False", "True"],help="choose hourly billing(0) or monthly billing(1)")
parser.add_argument("-iid", "--imageid", help="choose the image for your VM")
parser.add_argument("-rid", "--regionid", help="choose the region you want to be in")
parser.add_argument("-vid", "--vlanid", help="choose the vlan you want to be in")
parser.add_argument("-lip", "--localip", help="enter the local interface's ip address X.X.X.X")
parser.add_argument("-nId", "--networkid", help="enter the public network id address")
parser.add_argument("--sshkey", help="type your SSHKEY")
args = parser.parse_args()

app_key=args.applicationkey
app_secret=args.applicationsecret
consumer_k=args.consumerkey
projectid=args.projectid
pname=args.projectname
flavortype=args.flavorid
groupid=args.groupid
billtype=args.monthlybilling
imageid=args.imageid
regionid=args.regionid
vlanid=args.vlanid
localip=args.localip
networkId=args.networkid
sshid=args.sshkey

# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page

client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key=app_key,    # Application Key
    application_secret=app_secret, # Application Secret
    consumer_key=consumer_k,       # Consumer Key
)


result = client.post('/cloud/project/'+projectid+'/instance', 
    flavorId=flavortype, #// Instance flavor id (type: string)
#    groupId=groupid, #// Start instance in group (type: string)
    imageId=imageid, #// Instance image id (type: string)
    monthlyBilling=False, #// Active monthly billing (type: boolean)
    networks=[{"networkId":""+networkId+""},{"networkId":""+vlanid+"","ip":""+localip+""}], # Create network interfaces (type: cloud.instance.NetworkParams[])
    name=pname, #// Instance name (type: string)
#    networks=None, #// Create network interfaces (type: cloud.instance.NetworkParams[])
    region=regionid, #// Instance region (type: string)
    sshKeyId=sshid, #// SSH keypair id (type: string)
#    userData="sudo apt-get update; sudo apt-get install -y tree" , #// Configuration information or scripts to use upon launch (type: text)
#    volumeId=None,
)

# Pretty print
#print (json.dumps(result, indent=4))
id_instance = result['id']


for i in range(0,100):
    	try:
		getip = client.get('/cloud/project/'+projectid+'/instance/'+id_instance)
		print (getip['ipAddresses'][0]['ip'])
    		break
	except:
    		continue
    	else:
     		 break
    # we failed all the attempts - deal with the consequences.
