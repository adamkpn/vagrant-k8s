#!/bin/sh
curl -o /tmp/helm.tar.gz https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz 
tar -zxf /tmp/helm.tar.gz -C /tmp
cp /tmp/linux-amd64/helm /usr/local/bin/helm
