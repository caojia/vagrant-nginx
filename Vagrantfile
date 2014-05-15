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
  config.vm.provision "shell", inline: "/etc/init.d/iptables stop"

  logstash_count = 1
  logstash_collector_ips = (1..logstash_count).map {|i| "10.30.3.#{30+i}" }
  kafka_brokers = "10.30.3.10:9092,10.30.3.20:9092,10.30.3.30:9092"

  (1..logstash_count).each do |i|
    config.vm.define "logstash#{i}" do |s|
      ip = "10.30.3.#{30+i}"
      s.vm.hostname = "logstash#{i}"
      s.vm.network "private_network", ip: ip, netmask: "255.255.255.0", virtualbox__intnet: "servidors", drop_nat_interface_default_route: true
      s.vm.provision "shell", path: "scripts/init_logstash.sh", args: "collector \"#{ip}\" \"#{kafka_brokers}\""
      s.vm.provision "shell", path: "scripts/init_redis.sh"
      s.vm.provision "shell", path: "scripts/init_logstash_kafka.sh"
      s.vm.provision "shell", inline: "service logstash stop"
      s.vm.provision "shell", inline: "service logstash start"
    end
  end

  def quote_array(arr)
    arr.map {|e| '"' + e + '"' }.join(" ,")
  end

  (1..1).each do |i|
    config.vm.define "nginx#{i}" do |s|
      s.vm.hostname = "nginx#{i}"
      s.vm.network "private_network", ip: "10.30.3.#{20+i}", netmask: "255.255.255.0", virtualbox__intnet: "servidors", drop_nat_interface_default_route: true
      s.vm.provision "shell",
        path: "scripts/init_logstash.sh",
        args: "nginx '#{quote_array(logstash_collector_ips)}'"
      s.vm.provision "shell", path: "scripts/init_nginx.sh"
      s.vm.provision "shell", inline: "service logstash stop"
      s.vm.provision "shell", inline: "service logstash start"
    end
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

end
