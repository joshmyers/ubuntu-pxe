# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box      = "ubuntu/xenial64"
  config.vm.hostname = "pxe.hmpo.net"

  config.vm.network "public_network", ip: "192.168.87.254"

  config.vm.provider "virtualbox" do |vb|
    vb.customize [
      'modifyvm', :id,
      '--memory', 2048
    ]
  end
end
