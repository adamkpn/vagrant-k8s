#!/bin/sh
# Configure RBAC for Canal
kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/canal/rbac.yaml

# Install Canal with the Kubernetes API datastore
curl https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/canal/canal.yaml | sed 's/extensions\/v1beta1/apps\/v1/g' | kubectl apply -f -