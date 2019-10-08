Vagrant.configure("2") do |config|

	# Define Box as Centos 7 (latest version)
    config.vm.box = "centos/7"
	
	# Define VM resources
	config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
    end
	
    # Remove Swap File
	config.vm.provision "shell", path: "provision/common/remove_swap.sh", privileged: true
	# Install Docker on all nodes
	config.vm.provision "shell", path: "provision/common/install_docker.sh", privileged: true
	# Restart Docker daemon
	config.vm.provision "shell", path: "provision/common/restart_docker.sh", privileged: true
	# Install Kubelet, Kubectl and Kubeadm on all nodes
	config.vm.provision "shell", path: "provision/common/install_3_ks.sh", privileged: true

    # First Manager##
    (1..1).each do |number|
        config.vm.define "m#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.99.20#{number}"
            node.vm.hostname = "m#{number}"
			# Open firewall rules required for Master
			node.vm.provision "shell", path: "provision/master/open_firewall_rules.sh", privileged: true
			# Override hosts file in /etc/hosts
			node.vm.provision "shell", inline: "cp /vagrant/files/hosts /etc/hosts", privileged: true
			# Kubeadm Init:
			node.vm.provision "shell", path: "provision/master/kubeadm_init.sh", privileged: true
			# Expose 8080 for connection to Cluster from Kubectl
			node.vm.provision "shell", path: "provision/master/create_kubeconfig.sh", privileged: false
			# Install CNI
			node.vm.provision "shell", path: "provision/master/calico_cni.sh", privileged: false
			# Add kubectl alias
			node.vm.provision "shell", inline: "echo alias k='kubectl' >> ~/.bashrc", privileged: false
			# Install zsh
			node.vm.provision "shell", path: "provision/master/install_zsh.sh", privileged: false
        end  
    end

    # Workers
    (1..2).each do |number|
        config.vm.define "w#{number}" do |node|
            node.vm.network "private_network", ip: "192.168.99.21#{number}"
            node.vm.hostname = "w#{number}"
			# Override hosts file in /etc/hosts
			node.vm.provision "shell", inline: "cp /vagrant/files/hosts /etc/hosts", privileged: true
			# Open firewall rules required for Node
			node.vm.provision "shell", path: "provision/node/open_firewall_rules.sh", privileged: true
			# Join Node to Cluster:
			node.vm.provision "shell", inline: "kubeadm join --token=9201e0.9c84a8ad258cf7ab --discovery-token-unsafe-skip-ca-verification 192.168.99.201:6443", privileged: true
        end  
    end
end