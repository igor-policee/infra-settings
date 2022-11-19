#!/bin/bash

# Disable SELinux

sed -i 's/SELINUX=permissive/SELINUX=disabled/' /etc/selinux/config