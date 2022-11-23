#!/bin/bash

# Enabling / Disabling proxy

if [[ ${#} -eq 1 ]]; then
    STATE=${1}
    if [[ ${STATE} == 'on' ]] && [[ ${STATE} != ${PROXY_STATE} ]]; then
        PROXY_URL="http://user81261:qdvs7j@185.198.153.134:3665"
        echo http_proxy=\"${PROXY_URL}\" >>/etc/environment
        echo https_proxy=\"${PROXY_URL}\" >>/etc/environment
        echo dns_proxy=\"${PROXY_URL}\" >>/etc/environment
        echo rsync_proxy=\"${PROXY_URL}\" >>/etc/environment
        echo no_proxy=\"localhost,127.0.0.1,localaddress,.localdomain.com\" >>/etc/environment
        echo "Acquire::http::Proxy \"$(echo ${PROXY_URL})\";" >>/etc/apt/apt.conf
        echo "Acquire::https::Proxy \"$(echo ${PROXY_URL})\";" >>/etc/apt/apt.conf

        echo PROXY_STATE=\"${STATE}\" >>/etc/environment
        source /etc/environment

    elif [[ ${STATE} == 'on' ]] && [[ ${STATE} == ${PROXY_STATE} ]]; then
        echo 'The proxy is already activated'
        exit 1

    elif [[ ${STATE} == 'off' ]]; then
        sed -i '/http_proxy/d' /etc/environment
        sed -i '/https_proxy/d' /etc/environment
        sed -i '/dns_proxy/d' /etc/environment
        sed -i '/rsync_proxy/d' /etc/environment
        sed -i '/no_proxy/d' /etc/environment
        sed -i '/Proxy/d' /etc/apt/apt.conf
        sed -i '/PROXY_STATE/d' /etc/environment

        source /etc/environment
    else
        echo 'Invalid argument. Possible values: on/off'
        exit 1
    fi

else
    echo 'Invalid number of arguments. Possible quantity: 1'
fi
