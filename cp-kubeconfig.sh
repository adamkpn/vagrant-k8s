#!/bin/bash

# install vagrant scp plugin
vagrant plugin install vagrant-scp

# copy kubeconfig from guest to host
scp m1:/home/vagrant/.kube/config kubeconfig
