# -*- encoding: utf-8 -*-
import ovh

# Instantiate. Visit https://api.ovh.com/createToken/?GET=/me
# to get your credentials
client = ovh.Client(
    endpoint='ovh-eu',
    application_key='*********',
    application_secret='*********',
    consumer_key='**********',
)

# Print nice welcome message
print "Welcome", client.get('/me')['firstname']

