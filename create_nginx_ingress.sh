#!/bin/bash
helm install stable/nginx-ingress --name nginx --set controller.metrics.enabled=true
