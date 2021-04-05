# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_IMAGE = "generic/centos8"

Vagrant.configure("2") do |config|
  config.vm.define "master" do |subconfig|
    subconfig.vm.box = BOX_IMAGE
    subconfig.vm.hostname = "master"
    subconfig.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)', ip: "192.168.0.44"
    subconfig.vm.network :private_network, ip: "192.168.56.34"
    subconfig.vm.synced_folder "/Users/belloau/Documents/ansible/autompls/", "/vagrant"
    subconfig.vm.provision "shell", path: "bootstrap.sh"
    subconfig.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
    end
  end
end

