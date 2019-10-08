#!/bin/bash

# Install test version of docker engine, also shell completions
yum -y install /vagrant/packages/docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch.rpm
yum -y install /vagrant/packages/docker-ce-17.03.2.ce-1.el7.centos.x86_64.rpm

# Add the vagrant user to the docker group
usermod -aG docker vagrant

# Restart docker to create a /etc/docker folder
systemctl start docker && systemctl stop docker

# Configure the docker engine
# Daemon options: https://docs.docker.com/engine/reference/commandline/dockerd/
# Set both unix socket and tcp to make it easy to connect both locally and remote
# You can add TLS for added security (docker-machine does this automagically)
# touch /etc/docker/daemon.json
# cat > /etc/docker/daemon.json <<END
# {
#     "hosts": [ 
#         "unix://",
#         "tcp://0.0.0.0:2375"
#     ],
#     "experimental": true,
#     "debug": true,
#     "metrics-addr": "0.0.0.0:9323",
# "exec-opts": ["native.cgroupdriver=systemd"]	
# }
# END

# Enable and Start Docker
# systemctl enable docker
# systemctl restart docker