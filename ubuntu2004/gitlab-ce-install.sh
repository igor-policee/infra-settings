#! /bin/bash

# Script for Installing GitLab Community Edition

APP_NAME='gitlab-ce'
EXEC_FILE='/opt/gitlab/bin/gitlab-ctl'

if [ ! -x ${EXEC_FILE} ]; then
    WHOAMI=$(whoami)

    if [ "${WHOAMI}" == 'root' ]; then
        apt update &&
            apt install -y openssh-server &&
            wget -qO - https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash &&
            apt install -y gitlab-ce

    else

        echo 'The instruction must be executed from the root user'
    fi
else
    echo "Application ${APP_NAME} is already installed"
fi
