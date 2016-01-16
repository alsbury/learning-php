# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty32"

    config.vm.network "private_network", ip: "10.10.10.35"

    # config.vm.synced_folder  "vagrant/sites", "/etc/httpd/sites-enabled", type: "nfs"
    config.vm.synced_folder "./", "/var/www/project",
      type: "nfs"
      # ,
      # rsync__auto: "true",
      # rsync__exclude: ".git/",
      # id: "shared-folder-id"

    config.vm.provision :shell, :inline => "ulimit -n 4048"
    config.vm.provision "shell", path: "vagrant/provision.sh"

    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
        vb.auto_nat_dns_proxy = false
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on" ]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on" ]
    end

    config.vm.hostname = "learning-php.local"

    # Requires Hostupdater plugin
    # shell command: vagrant plugin install vagrant-hostsupdater

    if Vagrant.has_plugin?('vagrant-hostsupdater')
    config.hostsupdater.aliases = []
    end

    config.vm.define "sandbox" do |sandbox|
    end

end
