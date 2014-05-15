# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos64"
  config.ssh.forward_agent = true
  config.vm.provision "shell", path: "scripts/init.sh"

  config.vm.define "nginx" do |s|
    s.vm.hostname = "nginx"
    s.vm.network "public_network", use_dhcp_assigned_default_route: true
    s.vm.network "private_network", ip: "10.30.3.100", netmask: "255.255.255.0", virtualbox__intnet: "servidors", drop_nat_interface_default_route: true
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

end
