#!/bin/bash
systemctl enable firewalld.service && systemctl start firewalld.service
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=6443 protocol=tcp accept' --set-description="Kubernetes API server"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=2379-2380 protocol=tcp accept' --set-description="etcd server client API"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10250 protocol=tcp accept' --set-description="Kubelet API"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10251 protocol=tcp accept' --set-description="kube-scheduler"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10252 protocol=tcp accept' --set-description="kube-controller-manager"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10255 protocol=tcp accept' --set-description="Read-only Kubelet API"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=179 protocol=tcp accept' --set-description="Calico networking (BGP)"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=4789 protocol=udp accept' --set-description="flannel networking (VXLAN)"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=5473 protocol=tcp accept' --set-description="Calico networking with Typha enabled"
firewall-cmd --reload