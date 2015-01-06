# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'tmux-berkshelf'
  if Vagrant.has_plugin? 'vagrant-omnibus'
    config.omnibus.chef_version = 'latest'
  end
  config.vm.box = 'puppetlabs/ubuntu-14.04-64-puppet'
  config.vm.network :private_network, type: 'dhcp'
  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      'recipe[tmux::default]'
    ]
  end
end
