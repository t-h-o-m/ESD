# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''
import json
import ovh

# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page
client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key='xxxxxxxxxx',    # Application Key
    application_secret='xxxxxxxxxx', # Application Secret
    consumer_key='xxxxxxxxxx',       # Consumer Key
)

result = client.post('/cloud/project/8b98da39645b4f119ae33b1087d2355f/instance', 
    flavorId=None, // Instance flavor id (type: string) # This field modifies the resources allocated to the machine.
    groupId=None, // Start instance in group (type: string) # This field is used to associate the instance with a group.
    imageId="07b741aa-3a50-45f4-8841-9692eea29428", // Instance image id (type: string) # This field allows you to choose the distribution to install.
    monthlyBilling=False, // Active monthly billing (type: boolean) # Choose the billing type
    name=None, // Instance name (type: string) # Choose a name for the instance
    networks=None, // Create network interfaces (type: cloud.instance.NetworkParams[]) # Define the identifier of an interface and the associated ip address
    region="SBG5", // Instance region (type: string) # Choose the location of the server
    sshKeyId=None, // SSH keypair id (type: string) # Enter the ssh key you created
    userData=None, // Configuration information or scripts to use upon launch (type: text) # Configuration information or scripts to use upon launch
    volumeId=None, // Specify a volume id to boot from it (type: string) # Specify a volume id to boot from it
)

# Pretty print
print json.dumps(result, indent=4)