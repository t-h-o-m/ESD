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
args = parser.parse_args()

app_key=args.applicationkey
app_secret=args.applicationsecret
consumer_k=args.consumerkey

# Instanciate an OVH Client.
# You can generate new credentials with full access to your account on
# the token creation page

client = ovh.Client(
    endpoint='ovh-eu',               # Endpoint of API OVH Europe (List of available endpoints)
    application_key=app_key,    # Application Key
    application_secret=app_secret, # Application Secret
    consumer_key=consumer_k,       # Consumer Key
)

result = client.get('/cloud/project')

# Pretty print
print (json.dumps(result, indent=4))