# -*- mode: ruby -*-
# vi: set ft=ruby noet shiftwidth=2 tabstop=2 :

def debian_puppet_preparation(config)
	config.vm.provision "shell", inline: <<-SHELL
	  if ! [ -d /etc/puppet ] ; then
			mkdir -p /etc/puppet
			touch /etc/puppet/hiera.yaml
			apt-get update
			apt-get install --yes puppet
		fi
	SHELL
end

def setup_machine(config, name, vm_type, cpus, ram, ip)
  config.vm.define name do |config|
		config.vm.hostname = name
    config.vm.box = "debian/jessie64"
    config.vm.provider vm_type do |v|
      v.memory = ram
			v.cpus = cpus
    end

		debian_puppet_preparation(config)

		# provisioning with puppet
    config.vm.provision "puppet" do |p|
			p.manifest_file = name+".pp"
      p.module_path = "modules"
			p.synced_folder_type = "rsync"
    end
    config.vm.network "private_network", ip: ip
  end
end	

Vagrant.configure(2) do |config|
  setup_machine(config, "elk", "virtualbox", 3, 4096, "192.168.33.2")
  setup_machine(config, "router", "virtualbox", 1, 1024, "192.168.33.3")
  setup_machine(config, "client", "virtualbox", 1, 1024, "192.168.33.4")
end

