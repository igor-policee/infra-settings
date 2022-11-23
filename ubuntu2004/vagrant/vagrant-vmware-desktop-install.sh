#!/bin/bash

# Script for Installing Vagrant

APP_NAME='vagrant'
EXEC_FILE='/usr/bin/vagrant'

if [ ! -x ${EXEC_FILE} ]; then
    WHOAMI=$(whoami)

    if [ "${WHOAMI}" == 'root' ]; then
        DOWNLOAD_DIR='/root/Downloads'

        # Install Vagrant
        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg &&
            echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list &&
            apt-get update &&
            apt-get install -y vagrant

        # Install Vagrant VMware Utility
        DOWNLOAD_SOURCE='https://releases.hashicorp.com/vagrant-vmware-utility/1.0.21/vagrant-vmware-utility_1.0.21_linux_amd64.zip'
        DOWNLOAD_FILE='vagrant-vmware-utility_1.0.21_linux_amd64.zip'

        mkdir -p ${DOWNLOAD_DIR} &&
            cd ${DOWNLOAD_DIR} &&
            wget ${DOWNLOAD_SOURCE} &&
            mkdir -p /opt/vagrant-vmware-desktop/bin &&
            unzip -d /opt/vagrant-vmware-desktop/bin ${DOWNLOAD_FILE} &&
            /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility certificate generate &&
            /opt/vagrant-vmware-desktop/bin/vagrant-vmware-utility service install

        # Install Vagrant VMware Desktop Plugin
        cd ${DOWNLOAD_DIR} &&
            wget https://raw.githubusercontent.com/hashicorp/vagrant-vmware-desktop/main/LICENSE &&
            vagrant plugin install vagrant-vmware-desktop &&
            vagrant plugin license vagrant-vmware-desktop ./LICENSE &&
            apt-get install -y ubuntu-desktop &&
            systemctl restart vagrant-vmware-utility
    else
        echo 'The instruction must be executed from the root user'
    fi
else
    echo "Application ${APP_NAME} is already installed"
fi
