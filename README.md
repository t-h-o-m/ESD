# Agilitation_S5SR_GIT_PROCEDURE

## Description
European Secured Databases is a students project done by a group of students of IN'TECH Sud.
Aimed to provide Agilitation an automation tool to create and configure virtual machines hosting MongoDB using OVH services.

## Install
The content of  `agilitation` is to be installed on an apache web server.
We use RSA keys to configure the machines on OVH. The private RSA key used should be located in `agilitation/id_rsa`.

## Information for use
We use the OVH API to automate the processes for fetching and sending information to the server. To use our solution, you will need credentials allowing the aplication modification of your OVH project (https://api.ovh.com/createToken/).

## Programs version used
Apache 2.4.25
php7.0.33
Python 3.5.3-1
pip 9.0.1
ovh 0.4.8

