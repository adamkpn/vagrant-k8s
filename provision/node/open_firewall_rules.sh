#!/bin/bash
systemctl enable firewalld.service && systemctl start firewalld.service
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10250 protocol=tcp accept' --set-description="Kubelet API"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=10255 protocol=tcp accept' --set-description="Read-only Kubelet API"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=30000-32767 protocol=tcp accept' --set-description="NodePort Services"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=179 protocol=tcp accept' --set-description="Calico networking (BGP)"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=4789 protocol=udp accept' --set-description="flannel networking (VXLAN)"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=5473 protocol=tcp accept' --set-description="Calico networking with Typha enabled"
firewall-cmd --permanent --zone=$(firewall-cmd --get-default-zone) --add-rich-rule='rule family=ipv4 source address="0.0.0.0/0" port port=8879 protocol=tcp accept' --set-description="Tiller"
firewall-cmd --reload