#!/bin/bash
helm install stable/nfs-server-provisioner --name=nfs-server --set=storageClass.defaultClass=true
