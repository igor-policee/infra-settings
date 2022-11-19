#!/bin/bash

# Script for Installing Nexus Repository

APP_NAME='nexus'
EXEC_FILE='/opt/nexus'

if [ ! -x ${EXEC_FILE} ]; then
    WHOAMI=$(whoami)

    if [ "${WHOAMI}" == 'root' ]; then
        # Install OpenJDK 1.8 on Ubuntu 20.04 LTS
        apt install -y openjdk-8-jre-headless &&
            mkdir -p /opt &&
            cd /opt &&
            wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz &&
            tar -zxvf latest-unix.tar.gz &&
            mv /opt/nexus-3.30.1-01 /opt/nexus

    else

        echo 'The instruction must be executed from the root user'
    fi
else
    echo "Application ${APP_NAME} is already installed"
fi
