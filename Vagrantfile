Vagrant.configure("2") do |config|

	# Define Box as Centos 7 (latest version)
    config.vm.box = "centos/7"
	
	# Define VM resources
	config.vm.provider "virtualbox" do |v|
        v.memory = 1200
        v.cpus = 1
    end
	
    # Remove Swap File
	config.vm.provision "shell", path: "provision/common/01_remove_swap.sh", privileged: true
	# Install Docker on all nodes
	config.vm.provision "shell", path: "provision/common/02_install_docker.sh", privileged: true
	# Copy the daemon.json to Guest
	config.vm.provision "shell", inline: "cp /vagrant/files/daemon.json /etc/docker/daemon.json", privileged: true
	# Restart Docker daemon
	config.vm.provision "shell", path: "provision/common/03_restart_docker.sh", privileged: true
	# Install Kubelet, Kubectl and Kubeadm on all nodes
	config.vm.provision "shell", path: "provision/common/04_install_3_k.sh", privileged: true

    # First Manager
    (1..1).each do |number|
        config.vm.define "m#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.99.20#{number}"
            node.vm.hostname = "m#{number}"
			# Open firewall rules required for Master
			node.vm.provision "shell", path: "provision/master/01_master_open_firewall_rules.sh", privileged: true
			# Override hosts file in /etc/hosts
			node.vm.provision "shell", inline: "cp /vagrant/files/hosts /etc/hosts", privileged: true
			# Kubeadm Init with the Flunnel Network:
			node.vm.provision "shell", inline: "kubeadm init --apiserver-advertise-address 192.168.99.20#{number} --pod-network-cidr=10.244.0.0/16 --token=9201e0.9c84a8ad258cf7ab", privileged: true
			# Expose 8080 for connection to Cluster from Kubectl
			node.vm.provision "shell", path: "provision/master/03_expose_kubectl_access.sh", privileged: false
			# Install and Configure the Flunnel Network
			node.vm.provision "shell", path: "provision/master/04_install_flunnel_network_provider.sh", privileged: false
			# Add kubectl alias
			node.vm.provision "shell", inline: "echo alias k='kubectl' >> ~/.bashrc", privileged: false
		
        end  
    end

    # Workers
    (1..2).each do |number|
        config.vm.define "w#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.99.21#{number}"
            node.vm.hostname = "w#{number}"
			# Override hosts file in /etc/hosts
			node.vm.provision "shell", inline: "cp /vagrant/files/hosts /etc/hosts", privileged: true
			# Flunnel Network:
			node.vm.provision "shell", inline: "echo --node-ip=192.168.99.21#{number} >> /etc/systemd/system/kubelet.service.d/10-kubeadm.conf", privileged: true
			# Open firewall rules required for Node
			node.vm.provision "shell", path: "provision/node/01_node_open_firewall_rules.sh", privileged: true
			# Join Node to Cluster:
			node.vm.provision "shell", inline: "kubeadm join --token=9201e0.9c84a8ad258cf7ab --discovery-token-unsafe-skip-ca-verification 192.168.99.201:6443", privileged: true
        end  
    end
end