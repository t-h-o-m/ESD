# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''

import json
import ovh
import sys
import argparse

# Creation of Script options
# This will help the user to understand Agilitation's Script
# by typing 'python3 scriptname.py -h'

parser = argparse.ArgumentParser()
parser.add_argument("-pn", "--projectname", help="choose your project name")
parser.add_argument("-gid", "--groupid", help="choose which groupid you want to be in, if none type None")
parser.add_argument("-fid", "--flavorid", help="choose which flavorId you want for your VM")
parser.add_argument("-mbill", "--monthlybilling", type=int, choices=[0, 1],help="choose hourly billing(0) or monthly billing(1)")
parser.add_argument("-iid", "--imageid", help="choose the image for your VM")
parser.add_argument("-rid", "--regionid", help="choose the region you want to be in")
args = parser.parse_args()

print(args.projectname)
print(args.flavorid)
print(args.groupid)
print(args.monthlybilling)
print(args.imageid)
print(args.regionid)


# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page

client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key='xxxxxxxxxx',    # Application Key
    application_secret='xxxxxxxxxx', # Application Secret
    consumer_key='xxxxxxxxxx',       # Consumer Key
)



'''result = client.post('/cloud/project/8b98da39645b4f119ae33b1087d2355f/instance', 
    flavorId="9b312f04-e6ff-493f-bbd1-134510f49258", #Instance flavor id (type: string) # This field modifies the resources allocated to the machine.
    groupId=None, #Start instance in group (type: string) # This field is used to associate the instance with a group.
    imageId="07b741aa-3a50-45f4-8841-9692eea29428", # Instance image id (type: string) # This field allows you to choose the distribution to install.
    monthlyBilling=False, # Active monthly billing (type: boolean) # Choose the billing type
    name=sys.argv[1], # Instance name (type: string) # Choose a name for the instance
    networks=None, # Create network interfaces (type: cloud.instance.NetworkParams[]) # Define the identifier of an interface and the associated ip address
    region="SBG5", # Instance region (type: string) # Choose the location of the server
    sshKeyId="63334e6f61325635", # SSH keypair id (type: string) # Enter the ssh key you created
    userData=None, # Configuration information or scripts to use upon launch (type: text) # Configuration information or scripts to use upon launch
    volumeId=None, # Specify a volume id to boot from it (type: string) # Specify a volume id to boot from it
)'''

# Pretty print
#print (json.dumps(result, indent=4))
