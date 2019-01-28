[Unit]
Description=Rancher Server
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStartPre=/usr/bin/docker pull rancher/rancher:${rancher_version}
ExecStart=/usr/bin/docker run --restart=unless-stopped -p ${rancher_https_port}:${rancher_https_port} -p ${rancher_http_port}:${rancher_http_port} --name rancher-master -v /home/ubuntu:/mnt rancher/rancher:${rancher_version}
ExecStop=/usr/bin/docker stop rancher