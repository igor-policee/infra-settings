#!/bin/bash

# Script for installing VMware Workstation Pro 16

APP_NAME='vmware'
EXEC_FILE='/usr/bin/vmware'

if [ ! -x ${EXEC_FILE} ]; then
    WHOAMI=$(whoami)

    if [ "${WHOAMI}" == 'root' ]; then
        DOWNLOAD_DIR='/root/Downloads'
        DOWNLOAD_SOURCE='https://filedn.com/lAv70NoRi0O8LpU8BzbIRXJ/software/VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle'
        DOWNLOAD_FILE='VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle'
        SERIAL_NUMBER='AZ3E8-DCD8J-0842Z-N6NZE-XPKYF'

        apt-get update &&
            apt-get install -y build-essential linux-headers-"$(uname -r)" &&
            mkdir -p ${DOWNLOAD_DIR} &&
            cd ${DOWNLOAD_DIR} &&
            wget "${DOWNLOAD_SOURCE}" &&
            chmod +x ${DOWNLOAD_FILE} &&
            sh ${DOWNLOAD_FILE} --console --set-setting vmware-workstation serialNumber ${SERIAL_NUMBER} &&
            apt-get install -y ubuntu-desktop

    else
        echo 'The instruction must be executed from the root user'
    fi
else
    echo "Application ${APP_NAME} is already installed"
fi
