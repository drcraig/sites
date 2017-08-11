# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-16.04"
  config.vm.box_download_insecure = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "2048"
   end
  
  config.vm.provision "initial", type:"ansible" do |ansible|
    ansible.playbook = "initial-bringup.yaml"
    ansible.raw_arguments = [
        "--diff"
    ]
  end

  config.vm.provision "playbook", type:"ansible" do |ansible|
    ansible.playbook = "playbook.yaml"
    ansible.extra_vars = "local_hostnames.yaml"
    ansible.raw_arguments = [
        "--diff"
    ]
  end
end
