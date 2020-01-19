#!/bin/sh
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# stop selinux
setenforce 0

# install 3 k's
yum install -y kubelet-1.13.11 kubeadm-1.13.11 kubectl-1.13.11

# configure sysctl
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# start kubelet
systemctl daemon-reload
systemctl enable kubelet && systemctl start kubelet

# pre-warm kubernetes images
kubeadm config images pull
