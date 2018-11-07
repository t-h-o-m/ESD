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

result = client.get('/cloud/project/8b98da39645b4f119ae33b1087d2355f/instance', 
    region=None, // Instance region (type: string)
)

# Pretty print
print json.dumps(result, indent=4)