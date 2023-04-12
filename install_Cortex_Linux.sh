#!/bin/bash
sudo mkdir -p /etc/panw
sudo tar xf /root/Cortex_linux_rpm.tar.gz
sudo cd /root/
sudo cp cortex.conf /etc/panw/
sudo yum -y install ./cortex-*.rpm