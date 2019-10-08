#!/bin/bash

# install pre-requisites
yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2

# add stable repository
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# install docker-ce
yum update -y && yum install -y docker-ce-18.06.2.ce

# create /etc/docker directory.
mkdir /etc/docker

# setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# restart Docker
systemctl daemon-reload

# add vagrant user to docker group
usermod -aG docker vagrant

# restart docker
systemctl enable docker
systemctl start docker && systemctl stop docker