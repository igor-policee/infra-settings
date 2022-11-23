#!/bin/bash

# Script for Installing Hashicorp Vault on Ubuntu 20.04 LTS

# Run "./proxy.sh on" before run this script

curl -x ${http_proxy} -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - &&
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" &&
    apt update &&
    apt install vault -y &&
    vault --version
