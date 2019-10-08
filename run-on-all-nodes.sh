#!/bin/bash

command=$@

set -x
for host in 201 211 212 213 214 215; do
    export DOCKER_HOST=172.16.0.$host
    eval $command
done
