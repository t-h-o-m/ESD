# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''
import json
import ovh
import sys
import argparse
import time


parser = argparse.ArgumentParser()
parser.add_argument("-vn", "--vlanname", help="choose your vlan name")
parser.add_argument("-vr", "--vlanregion", help="choose which region you want to be in")
parser.add_argument("-vid", "--vlanid", help="choose which vlanId you want for your vlan")
args = parser.parse_args()

vlanname=args.vlanname
vlanregion=args.vlanregion
vlanid=args.vlanid

# print (vlanname, type(vlanname))
# print (vlanregion, type(vlanregion))
#print (vlanid, type(vlanid))
# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page
client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key='sOnTv0t6pIgSSyGs',    # Application Key
    application_secret='RvNu7yF36Ms5ppBcNyXvKVoGQndwEmtr', # Application Secret
    consumer_key='t4l7VeXIe4CQ0n1exAIutQy5RD2RLV77',       # Consumer Key
)



# result = client.post('/cloud/project/8b98da39645b4f119ae33b1087d2355f/network/private', 
#     name=vlanname, # Network name (type: string)
#     regions=vlanregion, # Region where to activate private network. No parameters means all region (type: string[])
#     vlanId="0, # Vland id, between 0 and 4000. 0 value means no vlan. (type: long)
# )
result = client.post('/cloud/project/8b98da39645b4f119ae33b1087d2355f/network/private', 
    name=""+vlanname+"", # Network name (type: string)
    regions=[""+vlanregion+""], # Region where to activate private network. No parameters means all region (type: string[])
    vlanId=int(vlanid), # Vland id, between 0 and 4000. 0 value means no vlan. (type: long)
)


# Pretty print
id_network = result['id']


for i in range(0,1000):
        try:
			result = client.post('/cloud/project/8b98da39645b4f119ae33b1087d2355f/network/private/'+id_network+'/subnet',
    				dhcp=True, # Enable DHCP (type: boolean)
    				end='192.168.1.10', # Last IP for this region (eg: 192.168.1.24) (type: ip)
    				network='192.168.1.0/24', # Global network with cidr (eg: 192.168.1.0/24) (type: ipBlock)
    				noGateway=True, # Set to true if you don't want to set a default gateway IP (type: boolean)
   				region='SBG5', # Region where this subnet will be created (type: string)
    				start='192.168.1.1', # First IP for this region (eg: 192.168.1.12) (type: ip)
			)
			print (id_network)
			break
        except:
			continue
	else:
		exit# Pretty print


