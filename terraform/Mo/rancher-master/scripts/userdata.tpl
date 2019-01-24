#!/bin/bash -xe

while [ ! -f /var/lib/cloud/instance/scripts/rancher.conf ]; do sleep 1; done

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

cp /var/lib/cloud/instance/scripts/rancher.conf /etc/systemd/system/rancher.service
systemctl daemon-reload
systemctl enable rancher.service
systemctl start rancher.service
