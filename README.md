# European Secured Databases

## Description
European Secured Databases is a students project done by a group of students of IN'TECH Sud.
Aimed to provide Agilitation an automation tool to create and configure virtual machines hosting MongoDB using OVH services.

## Use of the project

### Installing
The content of  agilitation can be used as a is using an apache2 server.
This will allow the use of a website to interact with the scripts easily.

### Configuration
We use RSA keys to configure the machines on OVH. The private RSA key used should be given in the file `master.sh` on line 19.

## Information for use
We use the OVH API to automate the processes for fetching and sending information to the server. To use our solution, you will need credentials allowing the aplication modification of your OVH project (https://api.ovh.com/createToken/).

## Programs version used
Apache 2.4.25
php 7.0.33
Python 3.5.3-1
pip 9.0.1
ovh 0.4.8