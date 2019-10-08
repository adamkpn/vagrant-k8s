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
yum install -y docker-ce docker-ce-cli containerd.io

# add vagrant user to docker group
usermod -aG docker vagrant

# restart docker
systemctl enable docker
systemctl start docker && systemctl stop docker