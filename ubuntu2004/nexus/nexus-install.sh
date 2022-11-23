#!/bin/bash

# Script for Installing Nexus Repository

APP_NAME='nexus'
EXEC_FILE='/opt/nexus/bin/nexus'

if [ ! -x ${EXEC_FILE} ]; then
    WHOAMI=$(whoami)

    if [ "${WHOAMI}" == 'root' ]; then
        # Install Java on Ubuntu 20.04
        apt update -y &&
            apt install -y openjdk-8-jdk &&
            # Create Dedicated Nexus System Account
            useradd -M -d /opt/nexus -s /bin/bash -r nexus &&
            echo "nexus   ALL=(ALL)       NOPASSWD: ALL" >/etc/sudoers.d/nexus &&
            # Download Nexus Repository OSS Tarball
            wget -O /opt/nexus-3.29.2-02-unix.tar.gz \
                https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz &&
            # Install Nexus Repository Manager on Ubuntu 20.04
            mkdir -p /opt/nexus &&
            tar xzf /opt/nexus-3.29.2-02-unix.tar.gz -C /opt/nexus/ --strip-components=1 &&
            rm -f /opt/nexus-3.29.2-02-unix.tar.gz &&
            # Set the proper ownership of the nexus directory
            chown -R nexus: /opt/nexus &&
            # Add user configuration in /opt/nexus/bin/nexus.rc
            sed -i 's/#run_as_user=""/run_as_user="nexus"/' /opt/nexus/bin/nexus.rc &&
            # Change directory from ../sonatype-work to ./sonatype-work
            sed -i 's/..\/sonatype-work/.\/sonatype-work/' /opt/nexus/bin/nexus.vmoptions &&
            # Create Nexus Repository Systemd Service
            cp ./nexus.service /etc/systemd/system/nexus.service

    else

        echo 'The instruction must be executed from the root user'
    fi
else
    echo "Application ${APP_NAME} is already installed"
fi
