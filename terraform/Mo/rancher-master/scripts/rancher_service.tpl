[Unit]
Description=Rancher Server
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStartPre=/usr/bin/docker pull rancher/rancher:${rancher_version}
ExecStart=/usr/bin/docker run --restart=unless-stopped -p ${rancher_https_port}:${rancher_https_port} -p ${rancher_http_port}:${rancher_http_port} -v /var/lib/cloud/instance/scripts/rancher-node.pem:/mnt/rancher-node.pem rancher/rancher:${rancher_version}
ExecStop=/usr/bin/docker stop rancher