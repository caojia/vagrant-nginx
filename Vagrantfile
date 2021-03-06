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
  config.vm.provision "shell", inline: "/etc/init.d/iptables stop", run: "always"

  kafka_brokers = "10.30.3.2:9092,10.30.3.3:9092,10.30.3.4:9092"

  (1..1).each do |i|
    config.vm.define "nginx#{i}" do |s|
      s.vm.hostname = "nginx#{i}"
      s.vm.network "private_network", ip: "10.30.3.#{20+i}", netmask: "255.255.255.0"
      `mkdir -p ./log/nginx-#{i}/`
      s.vm.synced_folder "./log/nginx-#{i}/", "/var/log/nginx/", id: "vagrant-nginx-log",
        :owner => "nginx",
        :group => "adm"
      `mkdir -p ./log/flume-nginx-#{i}/`
      s.vm.synced_folder "./log/flume-nginx-#{i}/", "/var/log/flume/", id: "vagrant-flume-log",
        :owner => "flume",
        :group => "flume"

      s.vm.provision "shell", path: "scripts/init_nginx.sh", run: "always"
      s.vm.provision "shell", path: "scripts/init_flume.sh", args: kafka_brokers, run: "always"
    end
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

end
