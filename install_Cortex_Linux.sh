#!/bin/bash
sudo mkdir -p /etc/panw
sudo tar xf /home/cloud/Cortex_linux_rpm.tar.gz
sudo cp cortex.conf /etc/panw/
sudo yum -y install ./cortex-*.rpm