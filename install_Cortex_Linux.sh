#!/bin/bash
sudo mkdir -p /etc/panw
sudo tar xf /root/cloud/Cortex_linux_rpm.tar.gz
sudo cd /root/ && cp cortex.conf /etc/panw/ && yum -y install ./cortex-*.rpm