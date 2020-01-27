#!/bin/sh

# Initialize Kubernetes Cluster
kubeadm init --ignore-preflight-errors=NumCPU --apiserver-advertise-address $(hostname -i) --pod-network-cidr=10.244.0.0/16 --token=9201e0.9c84a8ad258cf7ab