# -*- encoding: utf-8 -*-
'''
First, install the latest release of Python wrapper: $ pip install ovh
'''
import json
import ovh
import sys
import argparse
import time


# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page
client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key='sOnTv0t6pIgSSyGs',    # Application Key
    application_secret='RvNu7yF36Ms5ppBcNyXvKVoGQndwEmtr', # Application Secret
    consumer_key='t4l7VeXIe4CQ0n1exAIutQy5RD2RLV77',       # Consumer Key
)


result = client.get('/cloud/project/8b98da39645b4f119ae33b1087d2355f/network/private')
small = 0
for element in result :
	if element['vlanId'] > small:
		small = element['vlanId']
	exit

print small
