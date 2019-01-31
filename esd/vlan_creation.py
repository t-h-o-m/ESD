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
parser.add_argument("-ak", "--applicationkey", help="enter your application key")
parser.add_argument("-as", "--applicationsecret", help="enter your application secret")
parser.add_argument("-ck", "--consumerkey", help="enter your consumer key")
parser.add_argument("-pid", "--projectid", help="enter your project id (cloud)")
parser.add_argument("-vn", "--vlanname", help="choose your vlan name")
parser.add_argument("-vr", "--vlanregion", help="choose which region you want to be in")
parser.add_argument("-vid", "--vlanid", help="choose which vlanId you want for your vlan")
args = parser.parse_args()

app_key=args.applicationkey
app_secret=args.applicationsecret
consumer_k=args.consumerkey
projectid=args.projectid
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
    application_key=app_key,    # Application Key
    application_secret=app_secret, # Application Secret
    consumer_key=consumer_k,       # Consumer Key
)




result = client.post('/cloud/project/'+projectid+'/network/private', 
    name=""+vlanname+"", # Network name (type: string)
    regions=[""+vlanregion+""], # Region where to activate private network. No parameters means all region (type: string[])
    vlanId=int(vlanid), # Vland id, between 0 and 4000. 0 value means no vlan. (type: long)
)


# Pretty print
id_network = result['id']


for i in range(0,1000):
        try:
			result = client.post('/cloud/project/'+projectid+'/network/private/'+id_network+'/subnet',
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


