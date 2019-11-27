# -*- mode: ruby -*-
# vi: set ft=ruby :
#

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  config.vm.provision "shell", inline: %Q{
    cp -r /vagrant/.vim* /root
    rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
    yum -y install git vim tree
    echo 'export PATH=$PATH:/opt/puppetlabs/bin' >> /root/.bashrc
  }

  config.vm.define 'puppet' do |puppet|
    puppet.vm.hostname = 'puppet.localdomain'
    puppet.vm.network "private_network", type: "dhcp"
    puppet.vm.provision "shell", inline: "yum -y install puppetserver"
    puppet.vm.provider :virtualbox do |v|
      v.memory = 4096
    end
  end

  config.vm.define 'agent', autostart: false do |agent|
    agent.vm.hostname = 'agent.localdomain'
    agent.vm.provision "shell", inline: "yum -y install puppetserver"
    agent.vm.network "private_network", type: "dhcp"
  end

end


