#!/bin/bash

# copy kubeconfig from guest to host
vagrant scp m1:/home/vagrant/.kube/config kubeconfig

echo "configuring KUBECONFIG ..."
export KUBECONFIG=$(pwd)/kubeconfig
