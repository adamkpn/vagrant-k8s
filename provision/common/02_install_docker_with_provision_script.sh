#!/bin/bash

# Install test version of docker engine, also shell completions
curl -fsSL https://get.docker.com/ | sh

# Add the vagrant user to the docker group
usermod -aG docker vagrant

# Configure the docker engine
# Daemon options: https://docs.docker.com/engine/reference/commandline/dockerd/
# Set both unix socket and tcp to make it easy to connect both locally and remote
# You can add TLS for added security (docker-machine does this automagically)
cat > /etc/docker/daemon.json <<END
{
    "hosts": [ 
        "unix://",
        "tcp://0.0.0.0:2375"
    ],
    "experimental": true,
    "debug": true,
    "metrics-addr": "0.0.0.0:9323" 
}
END

# Enable and Start Docker
systemctl enable docker
systemctl restart docker

# Make sure that the cgroup driver used by kubelet is the same as the one used by Docker
cat << EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

# Restart Docker
systemctl enable docker && systemctl start docker

