#!/bin/bash
sudo mkdir -p /etc/panw
sudo tar xf /home/cloud/Cortex_linux_rpm.tar.gz
sudo cd /home/cloud/ && cp cortex.conf /etc/panw/ && yum -y install ./cortex-*.rpm