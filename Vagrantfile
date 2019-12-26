# -*- mode: ruby -*-
# vi: set ft=ruby :
#
#

PUPPETSERVER_IP="192.168.15.2"
PUPPETAGENT_IP="192.168.15.3"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"

  config.vm.provision "shell", inline: %Q{
    cp -r /vagrant/.vim* /root
    cp -r /vagrant/profile /etc/profile.d/puppet-training.sh
    rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
    yum -y install git vim tree
    mkdir -p /etc/puppetlabs/facter/facts.d
  }

  config.vm.define 'puppet' do |puppet|
    puppet.vm.hostname = 'puppet.localdomain'
    puppet.vm.network "private_network", ip: PUPPETSERVER_IP
    puppet.vm.provision "shell", inline: %Q{
      yum -y install puppetserver
      puppet module install puppetlabs-accounts --version 6.0.0
      puppet module install puppetlabs-motd --version 4.0.0
      cp /vagrant/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp
      rm -rf /etc/puppetlabs/code/environments/production/hiera.yaml
      echo "datacenter=london" > /etc/puppetlabs/facter/facts.d/datacenter.txt
   }

    puppet.vm.provider :virtualbox do |v|
      v.memory = 4096
    end
  end

  config.vm.define 'agent', autostart: false do |agent|
    agent.vm.hostname = 'agent.localdomain'
    agent.vm.provision "shell", inline: %Q{
      yum -y install puppetserver
      echo "datacenter=newyork" > /etc/puppetlabs/facter/facts.d/datacenter.txt
      echo "#{PUPPETSERVER_IP} puppet" >> /etc/hosts
    }
    agent.vm.network "private_network", ip: PUPPETAGENT_IP
  end

end


