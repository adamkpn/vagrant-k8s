#!/bin/sh
curl https://docs.projectcalico.org/v3.9/manifests/calico.yaml | kubectl apply -f -